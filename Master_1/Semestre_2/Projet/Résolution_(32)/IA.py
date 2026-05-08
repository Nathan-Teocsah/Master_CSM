import numpy as np
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt

# --- Constantes physiques ---
G = 6.67430e-11          # m^3 kg^-1 s^-2
M0 = 6.4185e23           # Masse de Mars (kg)
m = 1.06e16             # Masse de Phobos (kg)
R = 3396.2e3            # Rayon de Mars (m)
k2 = 0.15               # Nombre de Love pour Mars
omega_p = 2 * np.pi / (24.622962 * 3600)  # Vitesse de rotation de Mars (rad/s)
roche = 2.2 * R          # Limite de Roche (m)

# --- Paramètres du modèle ---
alpha = 0.3             # Exposant de la loi de puissance
E_values = {
    0.2: 1.201e8 * 86400,   # 1201 × 10^5 day rad^-1 → s rad^-1
    0.3: 81028 * 86400,      # 81028 day rad^-1 → s rad^-1
    0.4: 2104 * 86400        # 2104 day rad^-1 → s rad^-1
}
E_alpha = E_values[alpha]  # Paramètre E pour le alpha choisi

# --- Conditions initiales ---
a0 = 9377e3              # Demi-grand axe initial (m)
x0 = a0                  # Position initiale (x)
y0 = 0                   # Position initiale (y)
v0 = np.sqrt(G * (M0 + m) / a0)  # Vitesse orbitale circulaire (m/s)
vx0 = 0                 # Vitesse initiale (vx)
vy0 = v0                 # Vitesse initiale (vy)

# --- Fonctions auxiliaires ---
def n(a):
    """Fréquence orbitale (rad/s)."""
    return np.sqrt(G * (M0 + m) / a**3)

def chi(r, v):
    """Fréquence tidale principale (rad/s)."""
    # Calcul de |omega_p × r - v|
    omega_p_vec = np.array([0, 0, omega_p])
    r_vec = np.array([r[0], r[1], 0])
    v_vec = np.array([v[0], v[1], 0])
    cross_term = np.cross(omega_p_vec, r_vec) - v_vec
    return 2 * np.linalg.norm(cross_term)

def f_vec(r, v):
    """Calcule le vecteur lag f (équation 27)."""
    chi_val = chi(r, v)
    # Calcul de (omega_p × r - v)
    omega_p_vec = np.array([0, 0, omega_p])
    r_vec = np.array([r[0], r[1], 0])
    v_vec = np.array([v[0], v[1], 0])
    cross_term = np.cross(omega_p_vec, r_vec) - v_vec
    norm_cross = np.linalg.norm(cross_term)
    if norm_cross == 0:
        return np.array([0.0, 0.0])
    # Calcul de f (équation 27)
    a = np.linalg.norm(r_vec)
    f_magnitude = 0.5 * (E_alpha * chi_val)**(-alpha) * a
    f_dir = cross_term / norm_cross
    return f_magnitude * f_dir[:2]  # On retourne seulement les composantes x et y

# --- Équation différentielle (équation 32) ---
def dydt(t, y):
    """y = [x, y, vx, vy]"""
    x, y, vx, vy = y
    r_vec = np.array([x, y])
    v_vec = np.array([vx, vy])
    r = np.linalg.norm(r_vec)

    # Terme gravitationnel (2 corps)
    acc_grav = -G * (M0 + m) * r_vec / r**3

    # Terme de marée (équation 32)
    f = f_vec(r_vec, v_vec)
    acc_tide = - (3 * k2 * G * (M0 + m) * m * R**5) / (r**10 * M0) * (-f * r**2 - 2 * r_vec * np.dot(r_vec, f))

    # Accélération totale
    acc_x = acc_grav[0] + acc_tide[0]
    acc_y = acc_grav[1] + acc_tide[1]

    return [vx, vy, acc_x, acc_y]

# --- Condition d'arrêt : limite de Roche ---
def hit_roche(t, y):
    x, y, vx, vy = y
    r = np.linalg.norm([x, y])
    return r - roche
hit_roche.terminal = True
hit_roche.direction = -1

# --- Simulation ---
t_span = (0, 0.5e6 * 365.25 * 24 * 3600)  # 0.5 million d'années en secondes
y0 = [x0, y0, vx0, vy0]  # Conditions initiales [x, y, vx, vy]

print("Resolution de l'equation différentielle")
sol = solve_ivp(
    dydt,
    t_span,
    y0,
    method='RK45',
    rtol=1e-4,
    atol=1e-4,
    events=hit_roche,
    dense_output=True
)

# --- Extraction des résultats ---
t = sol.t
x = sol.y[0]
y = sol.y[1]
vx = sol.y[2]
vy = sol.y[3]

# Calcul de a(t) et Delta_t(t)
a = np.linalg.norm([x, y], axis=0)
Delta_t_vals = np.array([E_alpha * (2 * E_alpha * chi([xi, yi], [vxi, vyi])) ** (-alpha - 1) for xi, yi, vxi, vyi in zip(x, y, vx, vy)])

# --- Tracés ---
# 1. Trajectoire de Phobos
plt.figure(figsize=(10, 6))
plt.plot(x / 1e3, y / 1e3, label="Trajectoire de Phobos")
plt.gca().set_aspect('equal', adjustable='box')
plt.xlabel("x (km)")
plt.ylabel("y (km)")
plt.title("Trajectoire de Phobos (2D)")
plt.grid(True)
plt.legend()

# 2. Évolution de a(t)
plt.figure(figsize=(10, 6))
plt.plot(t / (365.25 * 24 * 3600) / 1e6, a / 1e3, label=f"α = {alpha}")
plt.xlabel("Temps (Millions d'années)")
plt.ylabel("Demi-grand axe (km)")
plt.title("Évolution du demi-grand axe de Phobos")
plt.grid(True)
plt.legend()

# 3. Évolution de Delta_t(t)
plt.figure(figsize=(10, 6))
plt.plot(t / (365.25 * 24 * 3600) / 1e6, Delta_t_vals / 60, label=f"Δt (min) pour α = {alpha}")
plt.xlabel("Temps (Millions d'années)")
plt.ylabel("Lag temporel (min)")
plt.title("Évolution du lag temporel")
plt.grid(True)
plt.legend()

plt.show()

# Temps de chute
if sol.t_events and len(sol.t_events[0]) > 0:
    t_crash = sol.t_events[0][0] / (365.25 * 24 * 3600) / 1e6
    print(f"Pour α = {alpha}, Phobos atteint la limite de Roche en {t_crash:.2f} Ma.")
else:
    print(f"Pour α = {alpha}, Phobos n'a pas atteint la limite de Roche après {t_span[1]/(365.25*24*3600)/1e6:.2f} Ma.")