import numpy as np
import matplotlib.pyplot as plt

T = 3.5e7 * 365.25 * 24 * 3600 # 35 millions d'années en secondes
G = 6.67430e-11 # constante gravitationnelle
M0 = 6.4185e23 # masse de Mars
m = 1.06e16 # masse de Phobos
R = 3396.2e3 # rayon de Mars (en mètres)
k2 = 0.169 # nombre de Love de Mars : https://arxiv.org/html/2405.05519v1
a0 = 9377e3 # demi-grand axe phobos (en mètres)
omega_p = 2*np.pi/(24.622962*3600) # vitesse de rotation de Mars (rad/s)
roche = 2.2*R # distance de Roche pour Phobos (en mètres) : https://www.insu.cnrs.fr/fr/cnrsinfo/phobos-la-lune-condamnee-pourquoi-mars-va-eroder-puis-disloquer-son-satellite
alpha = 0.4 # Exposant de la loi de puissance

def E(alpha) : # sec/rad (Q = E^alpha X^alpha)
    match alpha :
        case 0.2 : return  1201*10**5*24*3600
        case 0.3 : return 81028*24*3600
        case 0.4 : return 2104*24*3600

def n(a) : # fréquence orbitale de Phobos (rad/s)  
    return np.sqrt(G*(M0+m)/a**3)

def X(a) : # fréquence de marée principale (s^(-1))
    return 2*np.abs(omega_p - n(a))

def Delta_t(a) : # lag temporel (s)
    return E(alpha)**(-alpha) * X(a)**(-(alpha+1))

def f1(a) : # dérivée du demi-grand axe (m/s)
    numerateur = 6* k2 * R**5 * n(a) * m * Delta_t(a)
    denominateur = M0 * a**4
    val = -numerateur/denominateur * (n(a) - omega_p)
    if type(a) == np.ndarray :
        for i in range(len(a)) :
            if a[i] < roche :
                val[i] = 0
        return val
    else :
        if a < roche :
            val = 0
        return val
    

def f(a) :
    val = -C0 * a**(-5.5) * (C1*a**(-1.5) - omega_p)**(-alpha)
    if type(a) == np.ndarray :
        for i in range(len(a)) :
            if a[i] < roche :
                val[i] = 0
        return val
    if a < roche :
        val = 0
    return val
    

from scipy.integrate import solve_ivp

def da_dt_for_solve_ivp(t, a):
    return [f1(a[0])]  # solve_ivp attend un tableau

def df_x(a) :
    return B0 * a**(-6.5) * (C1*a**(-1.5) - omega_p)**(-alpha) - B1 * a**(-8) * (C1*a**(-1.5) - omega_p)**(-(alpha+1))


def euler_explicite(a0, T, dt) :
    t = np.linspace(0, T, int(T/dt)) # temps de 0 à T avec nb_point points
    a = np.zeros(len(t)) # tableau pour stocker les valeurs de a
    a[0] = a0
    for i in range(1, len(t)) :
        a[i] = a[i-1] + f1(a[i-1]) * dt # Euler explicite
    return t, a


import time

start_time = time.time()
sol_ref = solve_ivp(
    da_dt_for_solve_ivp,
    t_span=(0, T),
    y0=[a0],
    method='RK45',
    rtol=1e-10,  # Tolérance relative très stricte
    atol=1e-3,   # Tolérance absolue (1 mm)
    dense_output=True
)
end_time = time.time()
print("\n-----------------------------------------------")
print(f"Temps de calcul pour RK45 : {(end_time - start_time)*1000:.0f} milisecondes.")


# Résolution numérique de l'ODE
dt = 10**2 # pas de temps en années
dt = dt * 365.25 * 24 * 3600
start_time = time.time()
t, a = euler_explicite(a0, T, dt)
end_time = time.time()
print(f"Temps de calcul pour Euler explicite : {(end_time - start_time)*1000:.0f} milisecondes.")
print("------------------------------------------")
a_ref = sol_ref.sol(t)[0]



# Calcul du coefficient de Lipschitz pour la fonction f sur [roche, a0]
print("\nOrdre de grandeur des constantes : \n")
C0 = 6*k2*R**5*m/M0 * E(alpha)**(-alpha) * np.sqrt(G*(M0+m)) * 2**(-(alpha+1))
print(f"Constante C0 = {C0:E}")
print("-----------------------------------------")

C1 = np.sqrt(G*(M0+m))
B0 = C0*5.5
B1 = B0*alpha

Intervalle_a = np.linspace(roche, a0, 10000)

Lipschitz = np.max(np.abs(df_x(Intervalle_a)))
print(f"Constante de Lipschitz L = {Lipschitz:E}")
print("----------------------------------------")

count = 0
for i in range(len(Intervalle_a)) :
    if n(Intervalle_a[i]) < omega_p :
        count += 1
if count > 0 :
    print(f"---> !!!! Attention : n(a) < omega_p pour {count} valeurs de a dans l'intervalle [roche, a0].")

M2 = np.max(np.abs(df_x(Intervalle_a)*f(Intervalle_a)))
print(f"Constante M2_max = {M2:E}")
M2 = np.max(np.abs(df_x(a_ref)*f(a_ref)))
print(f"Constante M2_optim = {M2:E}")
print("----------------------------------------")


print(f"Temps de simulation T = {T:E} secondes.")
print("----------------------------------------")

C2 = np.exp(Lipschitz * T)*M2*T/2
print(f"On a |y_n - y(t_n)| < {C2:E}*h")
print("----------------------------------------")

print(f"pour h = {dt:E} secondes :\n |y_n - y(t_n)| < {C2*dt:.2f} m.")
print(f"Nombre de points : {T/dt:.3E}")

print(f" sup |met_Euler - met_RK45| = {np.max(np.abs(a - a_ref)):.2f} m.")


# Tracer de la courbe de f'(a) pour alpha = 0.2
plt.figure()
plt.plot(Intervalle_a, df_x(Intervalle_a), label="f'(a) pour alpha = 0.2")
plt.xlabel("a")
plt.ylabel("f(a)")
plt.title("Fonction f'(a) pour alpha = 0.2")
plt.grid()
plt.legend()

# Tracer de la courbe f(a) pour alpha = 0.2
plt.figure()
plt.plot(Intervalle_a, f(Intervalle_a), label="f(a) pour alpha = 0.2")
plt.xlabel("a")
plt.ylabel("f(a)")
plt.title("Fonction f(a) pour alpha = 0.2")
plt.grid()
plt.legend()

# Tracer de la courbe de f(a)f'(a) pour alpha = 0.2
plt.figure()
plt.plot(Intervalle_a, f(Intervalle_a)*df_x(Intervalle_a), label="f(a)f'(a) pour alpha = 0.2")
plt.xlabel("a")
plt.ylabel("f(a)f'(a)")
plt.title("Produit de f(a) et f'(a) pour alpha = 0.2")
plt.grid()
plt.legend()


plt.show()
