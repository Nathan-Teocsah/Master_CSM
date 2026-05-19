import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

# Constantes (unités SI)
G = 6.67430e-11          # m^3 kg^-1 s^-2
M0 = 5.9736e24          # kg (masse Terre)
m = 7.36e22             # kg (masse Lune)
R = 6.378e6             # m (rayon Terre)
k2 = 0.3019             # Nombre de Love (Terre)
a0 = 3.844e8            # m (demi-grand axe initial Lune)
Delta_t0 = 25           # s (lag temporel pour M2)
omega_p = 2 * np.pi / (0.99726949 * 24 * 3600)  # rad/s (vitesse rotation Terre)
n0 = 2 * np.pi / (27.321582 * 24 * 3600)        # rad/s (mouvement moyen Lune)

# Paramètres de simulation
alpha_values = [0.2, 0.3, 0.4]  # Exposants pour Q ~ chi^alpha
T = 2 * 365.25 * 24 * 3600   # 100 000 ans en secondes

# Fonctions
def E(alpha, Delta_t0, omega_p, n0):
    chi0 = 2 * np.abs(omega_p - n0)
    return (Delta_t0 * chi0**(alpha + 1))**(1/alpha)

def n(a):
    return np.sqrt(G * (M0 + m) / a**3)  # rad/s

def chi(a):
    return 2 * np.abs(omega_p - n(a))   # rad/s

def Delta_t(a, alpha, E_alpha):
    return E_alpha**(-alpha) * chi(a)**(-(alpha + 1))  # s

def da_dt(t, a, alpha, E_alpha):
    current_n = n(a)
    current_chi = chi(a)
    current_Delta_t = Delta_t(a, alpha, E_alpha)
    return - (6 * k2 * R**5 * current_n * m * current_Delta_t) / (M0 * a**4) * (current_n - omega_p)

# Simulation avec solve_ivp
def simulate(alpha):
    E_alpha = E(alpha, Delta_t0, omega_p, n0)
    def da_dt_wrapper(t, a):
        return da_dt(t, a[0], alpha, E_alpha)

    sol = solve_ivp(
        da_dt_wrapper,
        t_span=(0, T),
        y0=[a0],
        method='RK45',
        rtol=1e-9,
        atol=1e-6,
        dense_output=True
    )
    return sol.t, sol.y[0]

# Exécution et affichage
plt.figure(figsize=(12, 6))
for alpha in alpha_values:
    t, a = simulate(alpha)
    plt.plot(t / (365.25 * 24 * 3600), (a - a0)* 1e2, label=f"α = {alpha}")

plt.xlabel("Temps (Millénaires)")
plt.ylabel("Variation du demi-grand axe (cm)")
plt.title("Évolution du demi-grand axe de la Lune (Terre-Lune)")
plt.grid()
plt.legend()
plt.show()