import numpy as np
import matplotlib.pyplot as plt
import sys
from scipy.integrate import solve_ivp

# Constante
G = 6.67430e-11 # constante gravitationnelle
M0 = 6.4185e23 # masse de Mars
m = 1.06e16 # masse de Phobos
R = 3396.2e3 # rayon de Mars (en mètres)
k2 = 0.169 # 0.169 nombre de Love de Mars : https://arxiv.org/html/2405.05519v1
a0 = 9377e3 # demi-grand axe phobos (en mètres)
omega_p = 2*np.pi/(24.622962*3600) # vitesse de rotation de Mars (rad/s)
lim_roche = 2.2*R # distance de Roche pour Phobos (en mètres) : https://www.insu.cnrs.fr/fr/cnrsinfo/phobos-la-lune-condamnee-pourquoi-mars-va-eroder-puis-disloquer-son-satellite
a_min = R
alpha = [0.2, 0.3, 0.4] # Exposant de la loi de puissance
Q = 80

T = 4e7 * 365.25 * 24 * 3600 # 50 millions d'années en secondes
index = 0 # index pour alpha = 0.2
Alpha = alpha[index]
dt = 10**2 # pas de temps en années

#------------ FONCTIONS ------------

def E(alpha) : # sec/rad (Q = E^alpha X^alpha)
    match alpha :
        case 0.2 : return  1201*10**5*24*3600
        case 0.3 : return 81028*24*3600
        case 0.4 : return 2104*24*3600
        case 0 : return 2*Q

def n(a) : # fréquence orbitale de Phobos (rad/s)  
    return np.sqrt(G*(M0+m)/a**3)

def X(a) : # fréquence de marée principale (s^(-1))
    return 2*np.abs(omega_p - n(a))

def Delta_t(a, alpha) : # lag temporel (s)
    match alpha :
        case 0 : return (X(a)*Q)**(-1)
        case _ : return E(alpha)**(-alpha) * X(a)**(-(alpha+1))

def da_dt(a, alpha) : # dérivée du demi-grand axe (m/s)
    numerateur = 6* k2 * R**5 * n(a) * m * Delta_t(a, alpha)
    denominateur = M0 * a**4
    return -numerateur/denominateur * (n(a) - omega_p)

def da_dt_Kaula(a) : # dérivée du demi-grand axe (m/s)
    numerateur = 3* k2 * R**5 * G * m
    denominateur = Q * np.sqrt(G*(M0+m)) * a**(5.5)
    return -numerateur/denominateur

def euler_explicite(a0, alpha, T, dt) :
    a = [a0]
    t = [0]
    while t[-1] < T :
        if a[-1] < a_min :
            break
        k1 = da_dt(a[-1], alpha)
        k2 = da_dt(a[-1] + k1 * dt, alpha)
        a.append(a[-1] + (k1 + k2) * dt / 2) # Euler explicite
        t.append(t[-1]+dt)
    return np.array(t), np.array(a)

def euler_explicite_Kaula(a0, T, dt) :
    a = [a0]
    t = [0]
    while t[-1] < T :
        if a[-1] < a_min :
            break
        k1 = da_dt_Kaula(a[-1])
        k2 = da_dt_Kaula(a[-1] + k1 * dt)
        a.append(a[-1] + (k1 + k2) * dt / 2) # Euler explicite
        t.append(t[-1]+dt)
    return np.array(t), np.array(a)

def da_dt_for_solve_ivp(t, a):
    return [da_dt(a, Alpha)]  # solve_ivp attend un tableau

#------------------- VISUALISATION CONSTANTE --------------

dt = dt * 365.25 * 24 * 3600 # conversion du pas de temps en secondes
print("\n Pour alpha = 0.2")
print(f"Pas de temps : {dt:E} secondes.")
print(f"Pas de temps : {dt/(3600*24*365.25):E} années.")
print(f"Nombre de points : {int(T/dt):E}.")

# ------------- RESOLUTION -----------------------

t,a = euler_explicite(a0, Alpha, T, dt)
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
# ----------------- Calcul du moment de la limite de a_min et Erreur absolue ------------------------------

zero_euler = np.argmax(a < lim_roche)
zero_ref = np.argmax(a_RK45 < lim_roche)
print(f"Phobos atteint la Roche après {t[zero_euler]/(365.25*24*3600e6):.6f} millions d'années.")
print(f"Phobos atteint la Roche après {t[zero_ref]/(365.25*24*3600e6):.6f} millions d'années (référence RK45).")
print(f"----> Différence entre les deux méthodes : {(t[zero_euler] - t[zero_ref])/(365.25*24*3600e6):.6f} millions d'années.")

ind_roche = np.min([np.argmax(a <= lim_roche),np.argmax(a_RK45 <= lim_roche)])
print(f"\nTemps = [0; T]")
print(f" ---> sup |met_Euler - met_RK45| = {np.max(np.abs(a - a_RK45)):.6f} mètres.")
print(f"Temps = [0; T_(a_min)]")
print(f" ---> sup |met_Euler - met_RK45| = {np.max(np.abs(a[0:ind_roche] - a_RK45[0:ind_roche])):.6f} mètres.")

#----------------- AFFICHAGE DES GRAPHIQUES ------------------

tK,aK = euler_explicite_Kaula(a0, T, dt)
t3,a3 = euler_explicite(a0, 0.3, T, dt)
t4,a4 = euler_explicite(a0, 0.4, T, dt)

Delta = Delta_t(a, Alpha)
DeltaK = Delta_t(aK,0)
Delta3 = Delta_t(a3,0.3)
Delta4 = Delta_t(a4,0.4)

plt.figure()
plt.plot(t/(365.25*24*3600e6), a_RK45*10**(-3), label="(RK45) alpha = 0.2")
plt.plot(tK/(365.25*24*3600e6), aK*10**(-3), label="Kaula")
plt.plot(t/(365.25*24*3600e6), a*10**(-3), label="alpha = 0.2")
plt.plot(t3/(365.25*24*3600e6), a3*10**(-3), label="alpha = 0.3")
plt.plot(t4/(365.25*24*3600e6), a4*10**(-3), label="alpha = 0.4")
plt.plot(t/(365.25*24*3600e6), 10**(-3)*lim_roche*np.ones(len(t)), '--',label="Limite de a_min")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Demi-grand axe (km)")
plt.title("Évolution du demi-grand axe de Phobos")
plt.grid()
plt.legend()

plt.figure()
plt.plot(t/(365.25*24*3600e6), (a_RK45-a0)*10**(-3), label="(RK45) alpha = 0.2")
plt.plot(tK/(365.25*24*3600e6), (aK-a0)*10**(-3), label="Kaula")
plt.plot(t/(365.25*24*3600e6), (a-a0)*10**(-3), label="alpha = 0.2")
plt.plot(t3/(365.25*24*3600e6), (a3-a0)*10**(-3), label="alpha = 0.3")
plt.plot(t4/(365.25*24*3600e6), (a4-a0)*10**(-3), label="alpha = 0.4")
plt.plot(t/(365.25*24*3600e6), 10**(-3)*(lim_roche-a0)*np.ones(len(t)), '--',label="Limite de a_min")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Demi-grand axe (km)")
plt.title("Évolution du demi-grand axe de Phobos (a-a0)")
plt.grid()
plt.legend()

plt.figure()
plt.plot(tK/(365.25*24*3600e6), DeltaK/60, label="Kaula")
plt.plot(t/(365.25*24*3600e6), Delta/60, label="alpha = 0.2")
plt.plot(t3/(365.25*24*3600e6), Delta3/60, label="alpha = 0.3")
plt.plot(t4/(365.25*24*3600e6), Delta4/60, label="alpha = 0.4")
plt.xlabel("Temps (millilons d'années)")
plt.ylabel("Delta_t (min)")
plt.title("Évolution du lag temporel de Phobos")
plt.grid()
plt.legend()
plt.show()
