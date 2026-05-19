import numpy as np
import matplotlib.pyplot as plt
import sys
from scipy.integrate import solve_ivp
from sklearn.linear_model import LinearRegression

# Constante
G = 6.67430e-11 # constante gravitationnelle
M0 = 5.9736e24 # masse de la terre
m = 7.36e22 # masse de la lune
R = 6378e3 # rayon de la terre
k2 = 0.37 # nombre de love de la terre
a0 = 3.844e8 # demi-grand axe de la lune (en mètres)
Delta_t0 = 25 # Delta_t de terre-lune actuel
omega_p = 2*np.pi/(0.99726949*24*3600) # vitesse de rotation de la Terre sur elle même (rad/s)
n0 = 2*np.pi/(27.321582*24*3600) # vitesse de rotation de la lune autour de la terre
alpha = [0.2, 0.3, 0.4] # Exposant de la loi de puissance

T = 2 * 365.25 * 24 * 3600 # temps de simulation
index = 0 # index pour alpha = 0.2
Alpha = alpha[index]
dt = 0.01 # pas de temps en années
dt = dt * 365.25 * 24 * 3600 # conversion du pas de temps en secondes

#------------ FONCTIONS ------------

def E(alpha) : # sec/rad (Delta_t = E^{-alpha}(chi)^{-(alpha+1)} --> chi = 2(wp-n)
    chi0 =  2 * np.abs(omega_p - n0)
    E_alpha = chi0**(-(alpha+1))/Delta_t0
    E = E_alpha**(1/alpha)
    return E

def n(a) : # fréquence orbitale de Phobos (rad/s)  
    return np.sqrt(G*(M0+m)/a**3)

def X(a) : # fréquence de marée principale (s^(-1))
    return 2*np.abs(omega_p - n(a))

print((n(a0)-n0)/n0)

print(3600/X(a0))

def Delta_t(a, alpha) : # lag temporel (s)
    return E(alpha)**(-alpha) * X(a)**(-(alpha+1))

def da_dt(a, alpha) : # dérivée du demi-grand axe (m/s)
    numerateur = 6* k2 * R**5 * n(a) * m * Delta_t(a, alpha)
    denominateur = M0 * a**4
    return -numerateur/denominateur * (n(a) - omega_p)

def euler_explicite(a0, alpha, T, dt) :
    a = [a0]
    t = [0]
    while t[-1] < T :
        a.append(a[-1] + da_dt(a[-1], alpha) * dt) # Euler explicite
        t.append(t[-1]+dt)
    return np.array(t), np.array(a)

def da_dt_for_solve_ivp(t, a):
    return [da_dt(a, Alpha)]  # solve_ivp attend un tableau

#------------------- VISUALISATION CONSTANTE --------------

print("\n Pour alpha = 0.2")
print(f"Pas de temps : {dt:E} secondes.")
print(f"Pas de temps : {dt/(3600*24*365.25):E} années.")
print(f"Nombre de points : {int(T/dt):E}.")

# ------------- RESOLUTION -----------------------

t,a = euler_explicite(a0, 0.2, T, dt)
t3,a3 = euler_explicite(a0, 0.3, T, dt)
t4,a4 = euler_explicite(a0, 0.4, T, dt)

sol_ref = solve_ivp(
    da_dt_for_solve_ivp,
    t_span=(0, T),
    y0=[a0],
    method='RK45',
    rtol=1e-12,  # Tolérance relative très stricte
    atol=1e-9,   # Tolérance absolue (1 mm)
    dense_output=True
)
a_RK45 = sol_ref.sol(t)[0]
# ----------------- Calcul de l'Erreur absolue ------------------------------

print(f"\nTemps = [0; {T:.1E}]")
print(f" ---> sup |met_Euler - met_RK45| = {np.max(np.abs(a - a_RK45))*1e2:.6f} cm.")


#----------------------- Calcul coef erreur_infinis ---------------------------

# Create model instance
model = LinearRegression()

# Fit the model
model.fit(t.reshape(-1, 1)/(3600*24*365.25), (a-a0)*1e2)

# Get model parameters
print("\n---------- Eloignement de la lune : E(cm/an) -----------")
print(f"alpha = 0.2 ---> E = {model.coef_[0]:.2f} cm/an")
model.fit(t3.reshape(-1, 1)/(3600*24*365.25), (a3-a0)*1e2)
print(f"alpha = 0.3 ---> E = {model.coef_[0]:.2f} cm/an")
model.fit(t4.reshape(-1, 1)/(3600*24*365.25), (a4-a0)*1e2)
print(f"alpha = 0.4 ---> E = {model.coef_[0]:.2f} cm/an")

#----------------- AFFICHAGE DES GRAPHIQUES ------------------

Delta = Delta_t(a, 0.2)
Delta3 = Delta_t(a3,0.3)
Delta4 = Delta_t(a4,0.4)

chi = X(a)
chi3 = X(a3)
chi4 = X(a4)

delta = Delta*chi/2
delta3 = Delta3*chi3/2
delta4 = Delta4*chi4/2

a_s = 365.25*24*3600

plt.figure()
plt.plot(t/(365.25*24*3600), delta, label="alpha = 0.2")
plt.plot(t3/(365.25*24*3600), delta3, label="alpha = 0.3")
plt.plot(t4/(365.25*24*3600), delta4, label="alpha = 0.4")
plt.xlabel("Temps (année)")
plt.ylabel("lag")
plt.title("lag angulaire (en rad)")
plt.grid()
plt.legend()

plt.figure()
plt.plot(t/(365.25*24*3600), chi*a_s, label="alpha = 0.2")
plt.plot(t3/(365.25*24*3600), chi3*a_s, label="alpha = 0.3")
plt.plot(t4/(365.25*24*3600), chi4*a_s, label="alpha = 0.4")
plt.xlabel("Temps (années)")
plt.ylabel("Fréquence (en an^-1)")
plt.title("Évolution de la fréquence principale de marée")
plt.grid()
plt.legend()

plt.figure()
plt.plot(t/(365.25*24*3600), (a_RK45-a0)*10**(2), label="(RK45) alpha = 0.2")
plt.plot(t/(365.25*24*3600), (a-a0)*10**(2), label="alpha = 0.2")
plt.plot(t3/(365.25*24*3600), (a3-a0)*10**(2), label="alpha = 0.3")
plt.plot(t4/(365.25*24*3600), (a4-a0)*10**(2), label="alpha = 0.4")
plt.xlabel("Temps (années)")
plt.ylabel("Demi-grand axe (cm)")
plt.title("Évolution du demi-grand axe de Phobos (a-a0)")
plt.grid()
plt.legend()

plt.figure()
plt.plot(t/(365.25*24*3600), Delta, label="alpha = 0.2")
plt.plot(t3/(365.25*24*3600), Delta3, label="alpha = 0.3")
plt.plot(t4/(365.25*24*3600), Delta4, label="alpha = 0.4")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Delta_t (sec.)")
plt.title("Évolution du lag temporel de la lune")
plt.grid()
plt.legend()
plt.show()
