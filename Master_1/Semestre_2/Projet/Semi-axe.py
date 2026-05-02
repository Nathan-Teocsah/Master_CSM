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

def E(alpha) : # day/rad (Q = E^alpha X^alpha)
    match alpha :
        case 0.2 : return  1201
        case 0.3 : return 81028
        case 0.4 : return 2104

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

# Résolution numérique de l'ODE
T = 0.5e6 * 365.25 * 24 * 3600 # 4 millions d'années en secondes
nb_point = 100000
t = np.linspace(0, T, nb_point) # temps de 0 à T avec 10000 points
dt = t[1] - t[0] # pas de temps
a = np.zeros(nb_point) # tableau pour stocker les valeurs de a
Delta = np.zeros(nb_point) # tableau pour stocker les valeurs de Delta_t
n_phobos = np.zeros(nb_point) # tableau pour stocker les valeurs de n(a)
a[0] = a0
Delta[0] = Delta_t(a0, alpha[0])
n_phobos[0] = n(a0)
for i in range(1, nb_point) :
    a[i] = a[i-1] + da_dt(a[i-1], alpha[0]) * dt # Euler explicite pour alpha = 0.2
    Delta[i] = Delta_t(a[i], alpha[0])
    n_phobos[i] = n(a[i])

plt.figure()
plt.plot(t/(365.25*24*3600e6), a/1e3, label="Chute de a (km) pour alpha = 0.2")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Demi-grand axe (km)")
plt.title("Évolution du demi-grand axe de Phobos")
plt.grid()
plt.legend()

plt.figure()
plt.plot(t/(365.25*24*3600e6), Delta/60, label="Lag temporel pour alpha = 0.2")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Delta_t (min)")
plt.title("Évolution du lag temporel de Phobos")
plt.grid()
plt.legend()

plt.figure()
plt.plot(t/(365.25*24*3600e6), n_phobos, label="Fréquence orbitale de Phobos pour alpha = 0.2")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Fréquence orbitale (rad/s)")
plt.title("Évolution de la fréquence orbitale de Phobos")
plt.grid()
plt.legend()

plt.show()