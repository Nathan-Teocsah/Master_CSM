import numpy as np
import matplotlib.pyplot as plt

G = 6.67430e-11 # constante gravitationnelle
M0 = 6.4185e23 # masse de Mars
m = 1.06e16 # masse de Phobos
R = 3396.2e3 # rayon de Mars (en mètres)
k2 = 0.15 # nombre de Love de Mars (A revoir)
a0 = 9377e3 # demi-grand axe phobos (en mètres)
omega_p = 2*np.pi/(24.622962*3600) # vitesse de rotation de Mars (rad/s)
roche = 2.2*R # distance de Roche pour Phobos (en mètres) : https://www.insu.cnrs.fr/fr/cnrsinfo/phobos-la-lune-condamnee-pourquoi-mars-va-eroder-puis-disloquer-son-satellite
alpha = [0.2, 0.3, 0.4] # Exposant de la loi de puissance

def E(alpha) : # sec/rad (Q = E^alpha X^alpha)
    match alpha :
        case 0.2 : return  1201*10**5*24*3600
        case 0.3 : return 81028*24*3600
        case 0.4 : return 2104*24*3600

def n(a) : # fréquence orbitale de Phobos (rad/s)  
    return np.sqrt(G*(M0+m)/a**3)

def X(a) : # fréquence de marée principale (s^(-1))
    return 2*np.abs(omega_p - n(a))

def Delta_t(a, alpha) : # lag temporel (s)
    return E(alpha)**(-alpha) * X(a)**(-(alpha+1))

def da_dt(a, alpha) : # dérivée du demi-grand axe (m/s)
    numerateur = 6* k2 * R**5 * n(a) * m * Delta_t(a, alpha)
    denominateur = M0 * a**4
    if a < roche :
        return 0
    return -numerateur/denominateur * (n(a) - omega_p)

def euler_explicite(a0, alpha, T, dt) :
    t = np.linspace(0, T, int(T/dt)) # temps de 0 à T avec nb_point points
    a = np.zeros(len(t)) # tableau pour stocker les valeurs de a
    a[0] = a0
    for i in range(1, len(t)) :
        a[i] = a[i-1] + da_dt(a[i-1], alpha) * dt # Euler explicite
    return t, a

# Résolution numérique de l'ODE
T = 3.5e7 * 365.25 * 24 * 3600 # 50 millions d'années en secondes
index = 0 # index pour alpha = 0.2
Alpha = alpha[index]
dt = 10**2 # pas de temps en années
dt = dt * 365.25 * 24 * 3600 # conversion du pas de temps en secondes
print(f"Pas de temps : {dt:E} secondes.")
print(f"Pas de temps : {dt/(3600*24*365.25):E} années.")
print(f"Nombre de points : {int(T/dt):E}.")
t,a = euler_explicite(a0, Alpha, T, dt)


Delta = np.zeros(len(t)) # tableau pour stocker les valeurs de Delta_t
Delta[0] = Delta_t(a0, Alpha)
zero = -1 # index où a devient constant (Phobos atteint la Roche)
for i in range(1, len(t)) :
    Delta[i] = Delta_t(a[i], Alpha)
    if a[i] <= roche and zero == -1 : 
        zero = i

print(f"Phobos atteint la Roche après {t[zero]/(365.25*24*3600e6):.4f} millions d'années.")


print("Runge-Kutta 4ème ordre :")
from scipy.integrate import solve_ivp

def da_dt_for_solve_ivp(t, a):
    return [da_dt(a[0], Alpha)]  # solve_ivp attend un tableau

sol_ref = solve_ivp(
    da_dt_for_solve_ivp,
    t_span=(0, T),
    y0=[a0],
    method='RK45',
    rtol=1e-10,  # Tolérance relative très stricte
    atol=1e-3,   # Tolérance absolue (1 mm)
    dense_output=True
)

t_ref = sol_ref.t
a_ref = sol_ref.y[0]
zero_ref = np.argmax(a_ref < roche)
print(f"Phobos atteint la Roche après {t_ref[zero_ref]/(365.25*24*3600e6):.4f} millions d'années (référence RK45).")

plt.figure()
plt.plot(t_ref/(365.25*24*3600e6), a_ref/1e3, label="Chute de a (km) pour alpha = 0.2")
plt.plot(t/(365.25*24*3600e6), a/1e3,color='red', label="Chute de a (km) pour alpha = 0.2")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Demi-grand axe (km)")
plt.title("Évolution du demi-grand axe de Phobos")
plt.grid()
plt.legend()

plt.figure()
plt.plot(t_ref/(365.25*24*3600e6), Delta_t(a_ref, Alpha)/60, label="Lag temporel (en min) pour alpha = 0.2")
plt.plot(t/(365.25*24*3600e6), Delta/60, color='red', label="Lag temporel (en min) pour alpha = 0.2")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Delta_t (min)")
plt.title("Évolution du lag temporel de Phobos")
plt.grid()
plt.legend()


# Calcul de l'erreur 

Nb_point = 10**3 # nombre de points pour l'erreur
dt0 = 10**2  # pas de temps (en années) pour l'erreur

Erreur = np.zeros(Nb_point-1) # tableau pour stocker les erreurs
DT = np.zeros(Nb_point-1) # tableau pour stocker les pas de temps

dt0 = dt0 * 365.25 * 24 * 3600 # conversion du pas de temps en secondes

x_query = np.linspace(0, T, 10**2) # temps de 0 à T avec nb_point points
func_ref = np.interp(x_query, t_ref, a_ref) # interpolation de la solution de référence sur la grille commune
for i in range(2,Nb_point+1) :
    dt = i * dt0 # pas de temps qui varie de 5e8 à 5e11
    DT[i-2] = dt
    #print(f"\nCalcul de l'erreur pour dt = {dt/(365.25*24*3600):E} années.")
    #print(f"progression : {(i+1)/Nb_point*100:.2f} %")
    t,a = euler_explicite(a0, Alpha, T, dt)
    func = np.interp(x_query, t, a, left=np.nan, right=np.nan)
    Erreur[i-2] = np.max(np.abs(func - func_ref))

plt.figure()
plt.plot(DT/(365.25*24*3600), Erreur, '-+', label="Erreur relative en fonction du pas de temps")
plt.xlabel("pas de temps (années)")
plt.ylabel("Erreur (en km)")
plt.title("Erreur (en norme infinie) en fonction du pas de temps")
plt.xscale("log")
plt.yscale("log")
plt.grid()
plt.legend()

plt.show()