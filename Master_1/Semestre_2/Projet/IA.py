import numpy as np
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt

# --- Constantes physiques ---
G = 6.67430e-11          # Constante gravitationnelle (m^3 kg^-1 s^-2)
R = 3.397e6              # Rayon de Mars (m)
M_0 = 6.4171e23          # Masse de Mars (kg)
m = 1.0659e16            # Masse de Phobos (kg)
k_2 = 0.15               # Nombre de Love pour Mars
omega_p = 7.088e-5       # Vitesse de rotation de Mars (rad/s)

# --- Paramètres du modèle ---
# Valeurs de E (en day rad^-1) pour chaque alpha, converties en secondes
E_values = {
    0.2: 1.201e8 * 86400,   # 1201 × 10^5 day rad^-1 → s rad^-1
    0.3: 8.1028e4 * 86400,   # 81028 day rad^-1 → s rad^-1
    0.4: 2.104e3 * 86400     # 2104 day rad^-1 → s rad^-1
}

# --- Fonctions auxiliaires ---
def n(a):
    """Calcule la moyenne motion n (rad/s) pour un demi-grand axe a (m)."""
    return np.sqrt(G * M_0 / a**3)

def chi(a):
    """Calcule la fréquence tidale chi (rad/s) pour un demi-grand axe a (m)."""
    return 2 * np.abs(omega_p - n(a))

def Delta_t(a, alpha):
    """
    Calcule le lag temporel Delta_t (s) pour un demi-grand axe a (m) et un exposant alpha.
    Équation (29) : Delta_t = E * (2 * E * chi)^(-(alpha + 1))
    """
    E_alpha = E_values[alpha]
    chi_val = chi(a)
    return E_alpha * (2 * E_alpha * chi_val) ** (-alpha - 1)

# --- Équation différentielle (équation 36) ---
def da_dt(t, a, alpha):
    """
    Équation (36) : da/dt = - (6 * k_2 * R^5 * n * m * Delta_t) / (M_0 * a^4) * (n - omega_p)
    """
    a = a[0]  # solve_ivp attend un tableau
    n_val = n(a)
    Delta_t_val = Delta_t(a, alpha)
    return - (6 * k_2 * R**5 * n_val * m * Delta_t_val) / (M_0 * a**4) * (n_val - omega_p)

# --- Simulation ---
def simuler_phobos(alpha, a0, t_max):
    """
    Simule l'évolution de a en fonction du temps pour un alpha donné.
    """
    # Condition d'arrêt : a <= R (surface de Mars)
    def hit_surface(t, a):
        return a[0] - R

    hit_surface.terminal = True
    hit_surface.direction = -1

    # Résolution de l'ODE
    sol = solve_ivp(
        lambda t, a: da_dt(t, a, alpha),
        [0, t_max],
        [a0],
        method='RK45',
        rtol=1e-6,
        atol=1e-6,
        events=hit_surface
    )

    # Conversion du temps en années
    t_years = sol.t / (365.25 * 24 * 3600)

    return sol.t, sol.y[0], t_years

# --- Paramètres initiaux ---
a0 = 9.376e6              # Demi-grand axe initial de Phobos (m)
t_max = 5e7 * 365.25 * 24 * 3600  # 50 millions d'années en secondes

# --- Simulation pour différents alpha ---
alphas = [0.2, 0.3, 0.4]
results = {}

for alpha in alphas:
    t, a, t_years = simuler_phobos(alpha, a0, t_max)
    results[alpha] = (t_years, a)

# --- Tracé des résultats ---
plt.figure(figsize=(10, 6))
for alpha in alphas:
    t_years, a = results[alpha]
    plt.plot(t_years / 1e6, a / 1e3, label=f"α = {alpha}")

plt.xlabel("Temps (Millions d'années)")
plt.ylabel("Demi-grand axe (km)")
plt.title("Évolution du demi-grand axe de Phobos pour différents α")
plt.grid(True)
plt.legend()
plt.show()

# --- Temps de chute ---
for alpha in alphas:
    t_years, a = results[alpha]
    if len(sol.t_events[0]) > 0:  # Si Phobos a atteint la surface
        t_crash = sol.t_events[0][0] / (365.25 * 24 * 3600) / 1e6
        print(f"Pour α = {alpha}, Phobos atteint la surface de Mars en {t_crash:.2f} millions d'années.")
    else:
        print(f"Pour α = {alpha}, Phobos n'a pas atteint la surface après 50 millions d'années.")