import numpy as np
import matplotlib.pyplot as plt

G = 6.67430e-11 # constante gravitationnelle
M0 = 6.4185e23 # masse de Mars
m = 1.06e16 # masse de Phobos
R = 3396.2e3 # rayon de Mars (en mètres)
k2 = 0.169 # nombre de Love de Mars : https://arxiv.org/html/2405.05519v1
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
    t = np.arange(0, T, dt) # temps de 0 à T avec nb_point points
    a = np.zeros(len(t)) # tableau pour stocker les valeurs de a
    a[0] = a0
    for i in range(1, len(t)) :
        a[i] = a[i-1] + da_dt(a[i-1], alpha) * dt # Euler explicite
    return t, a

# Résolution numérique de l'ODE
T = 3.5*10**7 * 365.25 * 24 * 3600 # 50 millions d'années en secondes
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

from scipy.integrate import solve_ivp

def da_dt_for_solve_ivp(t, a):
    return [da_dt(a[0], Alpha)]  # solve_ivp attend un tableau

sol_ref = solve_ivp(
    da_dt_for_solve_ivp,
    t_span=(0, T),
    y0=[a0],
    method='RK45',
    rtol=1e-14,  # Tolérance relative très stricte
    atol=1e-6,   # Tolérance absolue (1 mm)
    dense_output=True
)

a_ref = sol_ref.sol(t)[0]
zero_ref = np.argmax(a_ref < roche)
print(f"Phobos atteint la Roche après {t[zero]/(365.25*24*3600e6):.6f} millions d'années.")
print(f"Phobos atteint la Roche après {t[zero_ref]/(365.25*24*3600e6):.6f} millions d'années (référence RK45).")
print(f"----> Différence entre les deux méthodes : {(t[zero] - t[zero_ref])/(365.25*24*3600*10**6):.6f} millions d'années.")
print(f"sup |met_Euler - met_RK45| = {np.max(np.abs(a - a_ref)):.6f} mètres.")




plt.figure()
plt.plot(t/(365.25*24*3600 * 10**6), a_ref*10**(-3), label="Chute de a (km) pour alpha = 0.2")
plt.plot(t/(365.25*24*3600 * 10**6), a*10**(-3), color='red', label="Chute de a (km) pour alpha = 0.2")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Demi-grand axe (km)")
plt.title("Évolution du demi-grand axe de Phobos")
plt.grid()
plt.legend()

plt.figure()
plt.plot(t/(365.25*24*3600 * 10**6), Delta_t(a_ref, Alpha)/60, label="Lag temporel (en min) pour alpha = 0.2")
plt.plot(t/(365.25*24*3600 * 10**6), Delta/60, color='red', label="Lag temporel (en min) pour alpha = 0.2")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Delta_t (min)")
plt.title("Évolution du lag temporel de Phobos")
plt.grid()
plt.legend()


# Calcul de l'erreur 
print("\n Calcul de l'erreur pour différents pas")
Nb_point = 10**3 # nombre de points pour l'erreur
dt0 = 10**2  # pas de temps initial pour l'erreur (en secondes)
dt_fin = 10**5

dt_fin = dt_fin * 365.25 * 24 * 3600 # conversion du pas de temps final en secondes
dt0 = dt0 * 365.25 * 24 * 3600 # conversion du pas de temps initial en secondes
DT = np.linspace(dt0, dt_fin, Nb_point)  # pas de temps (en années) pour l'erreur

Erreur = np.zeros(Nb_point) # tableau pour stocker les erreurs

import sys
import time
temps = np.zeros(Nb_point)
temps_total=time.time()
for i in range(Nb_point) :
    dt = DT[i]
    print(f"\rprogression : {(i+1)/Nb_point*100:.2f} %", end='', file=sys.stdout)
    temps[i] = time.time()
    t,a = euler_explicite(a0, Alpha, T, dt)
    temps[i] = time.time() - temps[i]
    ind_roche = np.min([np.argmax(a <= roche),np.argmax(sol_ref.sol(t)[0] <= roche)])
    Erreur[i] = np.max(np.abs(a[0:ind_roche] - sol_ref.sol(t)[0][0:ind_roche]))
    Erreur[i] = Erreur[i]/np.max(np.abs(sol_ref.sol(t)[0][0:ind_roche]))

print(f"\nTemps total = {time.time()-temps_total:.2f} s.")

print("\n\n Régression linéaire pour trouver l'ordre de convergence :")
from sklearn.linear_model import LinearRegression

# Sample data
x = np.log(DT).reshape(-1, 1)  # Reshape for scikit-learn
y = np.log(Erreur)

# Create model instance
model = LinearRegression()

# Fit the model
model.fit(x, y)

# Get model parameters
print(f"---> Ordre de convergence : {model.coef_[0]}")
print(f"Estimation de C : |y_n-y(t_n)| <= C*h^{model.coef_[0]}")
print(f"---> C = exp({model.intercept_}) = {np.exp(model.intercept_):E}")

plt.figure()
plt.plot(DT/(365.25*24*3600), Erreur)
plt.xlabel("pas de temps (années)")
plt.ylabel("Erreur (en km)")
plt.title("Erreur (en norme infinie) pour la méthode d'Euler")
plt.xscale("log")
plt.yscale("log")
plt.grid()

plt.figure()
plt.plot(DT/(365.25*24*3600), temps)
plt.xlabel("pas de temps (années)")
plt.ylabel("Temps (s.)")
plt.title("Temps d'execution de la méthode de Euler")
plt.xscale("log")
plt.yscale("log")
plt.grid()

plt.show()