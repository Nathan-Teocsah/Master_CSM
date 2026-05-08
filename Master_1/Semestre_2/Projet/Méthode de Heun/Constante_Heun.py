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
dt_max = 10**5 # En année
dt = 10**2 # En année (dt < dt_max)

def E(alpha) : # sec/rad (Q = E^alpha X^alpha)
    match alpha :
        case 0.2 : return  1201*10**5*24*3600
        case 0.3 : return 81028*24*3600
        case 0.4 : return 2104*24*3600

def n(a) : # fréquence orbitale de Phobos (rad/s)  
    return np.sqrt(G*(M0+m)/a**3)
    
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

def df_x(a) :
    return B0 * a**(-6.5) * (C1*a**(-1.5) - omega_p)**(-alpha) - B1 * a**(-8) * (C1*a**(-1.5) - omega_p)**(-(alpha+1))

def d2f_2x(a) :
    f1 = -7.5*a**(-7.5)*(C1*a**(-1.5)-omega_p)
    f2 = 1.5*alpha*a**(-9)*(C1*a**(-1.5)-omega_p)**(-alpha)
    f3 = -8*a**(-9)*(C1*a**(-1.5)-omega_p)
    f4 = 1.5*(alpha+1)*a**(-10.5)*(C1*a**(-1.5)-omega_p)**(-(alpha+2))
    return B0*(f1+f2)-B1*(f3 + f4)

# Calcul du coefficient de Lipschitz pour la fonction f sur [roche, a0]
import sys
if (dt > dt_max) :
    print("\n!!! dt est plus grand que dt_max !!")
    sys.exit()

print("\nOrdre de grandeur des constantes (Heun) : \n")
C0 = 6*k2*R**5*m/M0 * E(alpha)**(-alpha) * np.sqrt(G*(M0+m)) * 2**(-(alpha+1))

C1 = np.sqrt(G*(M0+m))
B0 = C0*5.5
B1 = B0*alpha

Intervalle_a = np.linspace(roche, a0, 10000)

Lipschitz = np.max(np.abs(df_x(Intervalle_a)))

count = 0
for i in range(len(Intervalle_a)) :
    if n(Intervalle_a[i]) < omega_p :
        count += 1
if count > 0 :
    print(f"---> !!!! Attention : n(a) < omega_p pour {count} valeurs de a dans l'intervalle [roche, a0].")
    sys.exit()

M2 = np.max(np.abs(df_x(Intervalle_a)*f(Intervalle_a))) #borne max de M2


print(f"Temps de simulation T = {T:E} secondes.")
print("----------------------------------------")

dt = dt * 365.25 * 24 * 3600
dt_max = dt_max * 365.25 * 24 * 3600
print(f"pour h_max = {dt_max:E}")
print("----------------------------------------")

print(f"Constante de Lipschitz L = {Lipschitz:E}")
print("----------------------------------------")

C2 = np.exp(Lipschitz * T)*M2*T/2
print(f"On a |y_n - y(t_n)| < {C2:E}*h")
print("----------------------------------------")
dt = dt * 365.25 * 24 * 3600
print(f"pour h = {dt:E} secondes :\n |y_n - y(t_n)| < {C2*dt:.2f} m.")
print(f"Nombre de points : {T/dt:.3E}")


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
plt.title(f"Fonction f(a) pour alpha = {alpha}")
plt.grid()
plt.legend()

# Tracer de la courbe de f(a)f'(a) pour alpha = 0.2
plt.figure()
plt.plot(Intervalle_a, f(Intervalle_a)*df_x(Intervalle_a), label="f(a)f'(a) pour alpha = 0.2")
plt.xlabel("a")
plt.ylabel("f(a)f'(a)")
plt.title(f"Fonction f(a)f'(a) pour alpha = {alpha}")
plt.grid()
plt.legend()


plt.show()
