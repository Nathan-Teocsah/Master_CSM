import os
import copy
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

plt.close()

donnees1 = []
donnees2 = []
fichier1 = "./results_parallel.txt"
fichier2 = "./results_serial.txt"
with open(fichier1) as fichier:
    print("\n --> Ouverture du fichier "+fichier1+"\n")
    for ligne in fichier:
        try: donnees1.append([float(x) for x in ligne.split()])
        except: continue
with open(fichier2) as fichier:
    print("\n --> Ouverture du fichier "+fichier2+"\n")
    for ligne in fichier:
        try: donnees2.append([float(x) for x in ligne.split()])
        except: continue

num = np.zeros(len(donnees1))
temps_par = np.zeros(len(donnees1))
temps_serial = np.zeros(len(donnees1))
quotient = np.zeros(len(donnees1))
for j in range(len(donnees1)) :
    num[j] = donnees1[j][0]
    temps_par[j] = donnees1[j][1]
    temps_serial[j] = donnees2[j][1]
    quotient[j] = temps_serial[j]/temps_par[j]

plt.figure()
plt.plot(num, temps_par, '-+', label="Parallèle")
plt.plot(num, temps_serial, '-+', label="Série")
plt.xlabel("M")
plt.ylabel("Temps (s.)")
plt.xscale("log")
plt.yscale("log")
plt.grid()
plt.title("Comparaison de temps entre Parallèle et série pour compter les nb premiers")
plt.legend()

plt.figure()
plt.plot(num, quotient, '-+')
plt.xlabel("M")
plt.ylabel("Taux")
plt.xscale("log")
plt.grid()
plt.title("Série/Parallèle")
plt.legend()
plt.show() 