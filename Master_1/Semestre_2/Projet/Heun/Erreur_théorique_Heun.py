import numpy as np
import matplotlib.pyplot as plt
import sys

T = 3.5e7 * 365.25 * 24 * 3600 # 35 millions d'années en secondes
G = 6.67430e-11 # constante gravitationnelle
M0 = 6.4185e23 # masse de Mars
m = 1.06e16 # masse de Phobos
R = 3396.2e3 # rayon de Mars (en mètres)
k2 = 0.169 # nombre de Love de Mars : https://arxiv.org/html/2405.05519v1
a0 = 9377e3 # demi-grand axe phobos (en mètres)
omega_p = 2*np.pi/(24.622962*3600) # vitesse de rotation de Mars (rad/s)
lim_roche = 2.2*R # distance de Roche pour Phobos (en mètres) : https://www.insu.cnrs.fr/fr/cnrsinfo/phobos-la-lune-condamnee-pourquoi-mars-va-eroder-puis-disloquer-son-satellite
a_min = lim_roche
alpha = 0.2 # Exposant de la loi de puissance
dt_max = 10**2 # En année
dt = 10**2 # En année (dt < dt_max)

def E(alpha) : # sec/rad (Q = E^alpha X^alpha)
    match alpha :
        case 0.2 : return  1201*10**5*24*3600
        case 0.3 : return 81028*24*3600
        case 0.4 : return 2104*24*3600

def n(a) : # fréquence orbitale de Phobos (rad/s)  
    return np.sqrt(G*(M0+m)/a**3)
    
def f(a,C0,C1) :
    return -C0 * a**(-5.5) * (C1*a**(-1.5) - omega_p)**(-alpha)

def df_x(a,B0,C1,B1) :
    return B0 * a**(-6.5) * (C1*a**(-1.5) - omega_p)**(-alpha) - B1 * a**(-8) * (C1*a**(-1.5) - omega_p)**(-(alpha+1))

def d2f_2x(a,C1,B0,B1) :
    f1 = -7.5*a**(-7.5)*(C1*a**(-1.5)-omega_p)
    f2 = 1.5*alpha*a**(-9)*(C1*a**(-1.5)-omega_p)**(-alpha)
    f3 = -8*a**(-9)*(C1*a**(-1.5)-omega_p)
    f4 = 1.5*(alpha+1)*a**(-10.5)*(C1*a**(-1.5)-omega_p)**(-(alpha+2))
    return B0*(f1+f2)-B1*(f3 + f4)

def Coef(a_min,B0,B1,C0,C1) :
    Lip = np.abs(df_x(a_min,B0,C1,B1))
    M2 = np.abs(df_x(a_min,B0,C1,B1)*f(a_min,C0,C1)) #borne max de M2
    N0 = np.abs(f(a_min,C0,C1))
    N1 = np.abs(df_x(a_min,B0,C1,B1))
    N2 = np.abs(d2f_2x(a_min,C1,B0,B1))
    C = 4*N0*N1**2 + 4*N0**2*N2 + 6*N0**2*N2
    C = C*T/24
    return np.exp(T*(Lip+dt_max*Lip**2/2))*C


# Calcul du coefficient de Lipschitz pour la fonction f sur [roche, a0]
if (dt > dt_max) :
    print("\n!!! dt est plus grand que dt_max !!")
    sys.exit()

print("\nOrdre de grandeur des constantes (Heun) : \n")
C0 = 6*k2*R**5*m/M0 * E(alpha)**(-alpha) * np.sqrt(G*(M0+m)) * 2**(-(alpha+1))

C1 = np.sqrt(G*(M0+m))
B0 = C0*5.5
B1 = B0*alpha

Intervalle_a = np.linspace(a_min, a0, 10000)

Lipschitz = np.max(np.abs(df_x(Intervalle_a,B0,C1,B1)))

count = 0
for i in range(len(Intervalle_a)) :
    if n(Intervalle_a[i]) < omega_p :
        count += 1
if count > 0 :
    print(f"---> !!!! Attention : n(a) < omega_p pour {count} valeurs de a dans l'intervalle [a_min, a0].")
    sys.exit()

M2 = np.max(np.abs(df_x(Intervalle_a,B0,C1,B1)*f(Intervalle_a,C0,C1))) #borne max de M2


print(f"Temps de simulation T = {T:E} secondes.")
print("----------------------------------------")

dt = dt * 365.25 * 24 * 3600
dt_max = dt_max * 365.25 * 24 * 3600
print(f"pour h_max = {dt_max:E}")
print("----------------------------------------")

print(f"Constante de Lipschitz L = {Lipschitz:E}")
print("----------------------------------------")

N0 = np.max(np.abs(f(Intervalle_a,C0,C1)))
N1 = np.max(np.abs(df_x(Intervalle_a,B0,C1,B1)))
N2 = np.max(np.abs(d2f_2x(Intervalle_a,C1,B0,B1)))
C = 4*N0*N1**2 + 4*N0**2*N2 + 6*N0**2*N2
C = C*T/24
C = np.exp(T*(Lipschitz+dt_max*Lipschitz**2/2))*C
print(f"On a |y_n - y(t_n)| < {C:E}*h^2")
print("----------------------------------------")
print(f"pour h = {dt:E} secondes :\n |y_n - y(t_n)| < {C*dt**2:E} m.")
print(f"Nombre de points : {T/dt:.3E}")

print(f"On a Err_rel = sup(|y_n - y(t_n)|) / sup(y(t_n)) < {C/np.abs(a0-T*N0):.3E}*h")
print("----------------------------------------\n")



# Calcul de C pour différentes valeurs de a_min

I = np.linspace(1.5*R,a0,1000)

max_err = 500 # en km

C_array = np.zeros(len(I))
a_precis = -1
ind_preci = -1
for i in range(len(I)) :
    C_array[i] = Coef(I[i],B0,B1,C0,C1)
    if a_precis == -1 and C_array[i]*dt<=max_err*1e3 :
        ind_preci = i
        a_precis = I[i]

print(f"C*dt <= {max_err:.2E} à partir de a_min = {a_precis*1e-3:.0f} km")

print("\n----------------------------------\n")

# Tracer de la courbe de f'(a) pour alpha = 0.2
plt.figure()
plt.plot(I[ind_preci:]*1e-3, C_array[ind_preci:], label="C(a)")
plt.xlabel("a_min en km")
plt.ylabel("C(a_min) en m/s")
plt.title(f"C (m/s) pour alpha = {alpha} --> Err_abs < C*dt")
plt.grid()
plt.legend()

plt.figure()
plt.plot(I[ind_preci:]*1e-3, C_array[ind_preci:]*dt*1e-3, label="C(a)")
plt.xlabel("a_min en km")
plt.ylabel("C * dt en km")
plt.title(f"C*dt km. pour alpha = {alpha} --> Err_abs < C*dt")
plt.grid()
plt.legend()
plt.show()