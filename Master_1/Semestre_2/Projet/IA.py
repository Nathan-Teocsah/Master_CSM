import numpy as np
import matplotlib.pyplot as plt

# Constantes
G = 6.67430e-11
M0 = 6.4185e23
m = 1.06e16
R = 3396.2e3
k2 = 0.15
a0 = 9377e3
omega_p = 2 * np.pi / (24.622962 * 3600)
roche = 2.2 * R
alpha = [0.2, 0.3, 0.4]

def E(alpha):
    match alpha:
        case 0.2: return 1201 * 10**5 * 24 * 3600
        case 0.3: return 81028 * 24 * 3600
        case 0.4: return 2104 * 24 * 3600

def n(a):
    return np.sqrt(G * (M0 + m) / a**3)

def X(a):
    return 2 * np.abs(omega_p - n(a))

def Delta_t(a, alpha):
    return E(alpha)**(-alpha) * X(a)**(-(alpha + 1))

def da_dt(a, alpha):
    if a < roche:
        return 0
    numerateur = 6 * k2 * R**5 * n(a) * m * Delta_t(a, alpha)
    denominateur = M0 * a**4
    return -numerateur / denominateur * (n(a) - omega_p)

def euler_explicite(a0, alpha, T, dt):
    t = np.arange(0, T, dt)
    a = np.zeros(len(t))
    a[0] = a0
    for i in range(1, len(t)):
        a[i] = a[i-1] + da_dt(a[i-1], alpha) * dt
    return t, a

# Paramètres de la simulation
T = 3.5e7 * 365.25 * 24 * 3600  # 35 millions d'années en secondes
Alpha = alpha[0]  # alpha = 0.2
Nb_point = 10  # Nombre de pas de temps à tester
dt0 = 1e6  # Pas de temps initial (11.5 jours en secondes)

# Calcul de la solution de référence avec le plus petit pas
dt_ref = dt0
t_ref, a_ref = euler_explicite(a0, Alpha, T, dt_ref)
zero_ref = np.argmax(a_ref < roche)  # Index où a_ref < roche
print(f"Phobos atteint la Roche après {t_ref[zero_ref]/(365.25*24*3600e6):.2f} millions d'années (référence).")

# Grille commune pour l'interpolation
x_query = np.linspace(0, T, int(T/dt_ref))
a_ref_interp = np.interp(x_query, t_ref, a_ref)

# Tableaux pour stocker les erreurs
Erreur_rel = np.zeros(Nb_point - 1)
Erreur_abs = np.zeros(Nb_point - 1)
DT = np.zeros(Nb_point - 1)
Temps_chute = np.zeros(Nb_point - 1)

for i in range(1, Nb_point):
    dt = i * dt0  # Pas de temps croissant
    DT[i-1] = dt
    print(f"\nCalcul pour dt = {dt/(365.25*24*3600):.2f} années.")
    t, a = euler_explicite(a0, Alpha, T, dt)
    zero = np.argmax(a < roche)
    Temps_chute[i-1] = t[zero] / (365.25 * 24 * 3600e6)  # Temps de chute en Ma
    a_interp = np.interp(x_query, t, a)
    Erreur_rel[i-1] = np.max(np.abs(a_interp - a_ref_interp) / a_ref_interp)
    Erreur_abs[i-1] = np.max(np.abs(a_interp - a_ref_interp))

# Tracé des erreurs
plt.figure(figsize=(12, 6))
plt.plot(DT/(365.25*24*3600), Erreur_rel, '-+', label="Erreur relative")
plt.xlabel("Pas de temps (années)")
plt.ylabel("Erreur relative")
plt.title("Erreur relative en fonction du pas de temps (Euler explicite)")
plt.xscale("log")
plt.yscale("log")
plt.grid(True)
plt.legend()

plt.figure(figsize=(12, 6))
plt.plot(DT/(365.25*24*3600), Erreur_abs/1e3, '-+', label="Erreur absolue (km)")
plt.xlabel("Pas de temps (années)")
plt.ylabel("Erreur absolue (km)")
plt.title("Erreur absolue en fonction du pas de temps (Euler explicite)")
plt.xscale("log")
plt.yscale("log")
plt.grid(True)
plt.legend()

plt.figure(figsize=(12, 6))
plt.plot(DT/(365.25*24*3600), Temps_chute, '-+', label="Temps de chute (Ma)")
plt.xlabel("Pas de temps (années)")
plt.ylabel("Temps de chute (Ma)")
plt.title("Temps de chute de Phobos en fonction du pas de temps")
plt.xscale("log")
plt.grid(True)
plt.legend()

plt.show()