import os
import copy
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

plt.close()

donnees = []

nom_fichier = "err01.csv"

with open(nom_fichier) as fichier:
    print("\n --> Ouverture du fichier "+nom_fichier+"\n")
    for ligne in fichier:
        try: donnees.append([float(x) for x in ligne.split()])
        except: continue



#--------------------- Ordre de convergence et Graphique ----------------    

Nb_maillage = len(donnees)

Err = np.zeros(Nb_maillage)
pas = np.zeros(Nb_maillage)

for j in range(Nb_maillage) :
    pas[j] = donnees[j][0]
    Err[j] = donnees[j][1]

#---------------- Ordre de convergence -------------    


x = np.log(pas).reshape(-1, 1)  # Reshape for scikit-learn
y = np.log(Err)
model = LinearRegression()
model.fit(x, y)

print(f" ---> Ordre de convergence = {model.coef_[0]}")

#------------------- Graphiques ---------------------------

plt.figure(1)
plt.plot(pas, Err, '-+', label=f"Erreur en norme ")
plt.xlabel("pas d'espace")
plt.ylabel("Erreur")
plt.xscale("log")
plt.yscale("log")
plt.grid()
plt.title("Erreurs pour les normes L1, L2 et Linf")
plt.legend()

plt.show()   

