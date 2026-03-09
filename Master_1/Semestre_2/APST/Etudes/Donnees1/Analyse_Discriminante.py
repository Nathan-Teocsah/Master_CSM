#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Mar 25 09:11:35 2018

@author: valerie
"""


# importation des données -----------------------------------------------------
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.metrics import confusion_matrix,ConfusionMatrixDisplay

path = "/home/maenwe/Master_CSM/Master_1/Semestre_2/APST/Etudes/Donnees1/"
Xp=np.loadtxt(path+"data.csv",delimiter=',',skiprows=1,usecols=range(1,20532))
nomvar=np.loadtxt(path+"labels.csv",delimiter=',',skiprows=1,dtype='str',usecols=0) # numéro des gênes
y=np.loadtxt(path+"labels.csv",delimiter=',',skiprows=1,dtype='str',usecols=1) # nom du cancer (il y a pleins de doublons)

X = StandardScaler().fit_transform(Xp)


# Analyse discriminante linéaire ----------------------------------------------
print("======= Analyse discriminante linéaire =======")

lda = LinearDiscriminantAnalysis() # Calcul 2 CHOSES : facteurs principaux et méthode d'analyse linéaire discriminantes
lda.fit(X,y)
yhat = lda.predict(X)
errl=100*np.count_nonzero(y!=yhat)/len(y)

print("Taux d'erreur: ",round(errl,3),"%")
print("")

plt.rcParams.update({'figure.figsize': (3,3),'font.size': 16})
conf_mat =  confusion_matrix(y,yhat)
ConfusionMatrixDisplay(conf_mat).plot(cmap='YlOrBr',colorbar=False)
plt.title("Linéaire")
plt.rcdefaults()

# Plan factoriel
C = lda.fit_transform(X, y)# On a 5 classes, donc 4 facteurs principaux
C1 = C[:,0] # Premier facteur principal
C2 = C[:,1] # Deuxième facteur principal
C3 = C[:,2] # Troisième facteur principal
C4 = C[:,3] # Quatrième facteur principal

plt.figure()
plt.title("Plan factoriel Linéaire")

plt.subplot(3,4,1)
plt.xlabel("C1")
plt.ylabel("C1")

plt.subplot(3,4,2)
plt.xlabel("C1")
plt.ylabel("C2")
vlab=np.unique(y) # Détruit les doublons
for i,vl in enumerate(vlab): 
  l=y==vl 
  plt.scatter(C1[l],C2[l],s=47,label=vl) 
plt.legend()

plt.subplot(3,4,3)
plt.xlabel("C1")
plt.ylabel("C3")
vlab=np.unique(y) # Détruit les doublons
for i,vl in enumerate(vlab): 
  l=y==vl 
  plt.scatter(C1[l],C3[l],s=47,label=vl) 
plt.legend()

plt.subplot(3,4,4)
plt.xlabel("C1")
plt.ylabel("C4")
vlab=np.unique(y) # Détruit les doublons
for i,vl in enumerate(vlab): 
  l=y==vl 
  plt.scatter(C1[l],C4[l],s=47,label=vl) 
plt.legend()

#Ligne 2
plt.subplot(3,4,5)
plt.xlabel("C2")
plt.ylabel("C1")

plt.subplot(3,4,6)
plt.xlabel("C2")
plt.ylabel("C2")

plt.subplot(3,4,7)
plt.xlabel("C2")
plt.ylabel("C3")
vlab=np.unique(y) # Détruit les doublons
for i,vl in enumerate(vlab): 
  l=y==vl 
  plt.scatter(C2[l],C3[l],s=47,label=vl) 
plt.legend()

plt.subplot(3,4,8)
plt.xlabel("C2")
plt.ylabel("C4")
vlab=np.unique(y) # Détruit les doublons
for i,vl in enumerate(vlab): 
  l=y==vl 
  plt.scatter(C2[l],C4[l],s=47,label=vl) 
plt.legend()

#Ligne 3
plt.subplot(3,4,9)
plt.xlabel("C3")
plt.ylabel("C1")

plt.subplot(3,4,10)
plt.xlabel("C3")
plt.ylabel("C2")

plt.subplot(3,4,11)
plt.xlabel("C3")
plt.ylabel("C3")  

plt.subplot(3,4,12)
plt.xlabel("C3")
plt.ylabel("C4")
vlab=np.unique(y) # Détruit les doublons
for i,vl in enumerate(vlab): 
  l=y==vl 
  plt.scatter(C3[l],C4[l],s=47,label=vl) 
plt.legend()

# Avec validation croisée : Linéaire

ntest=np.floor(len(y)/3).astype(int)
errl = 0
i = 0
i_max = 10
while i < i_max:
  per=np.random.permutation(len(y))
  lt,la=per[:ntest], per[ntest:]
  Xa,Xt=X[la,:],X[lt,:]
  ya,yt=y[la],y[lt]
  lda.fit(Xa,ya)
  yhat = lda.predict(Xt)
  errl += 100*np.count_nonzero(yt!=yhat)/len(yt)
  i += 1
errl /= i_max
print("======= Validation croisée : Linéaire =======")
print("Taux d'erreur: ",round(errl,3),"%")
print("")
print("")



# Analyse discriminante quadratique ----------------------------------------------
print("======= Analyse discriminante quadratique =======")
qda = QuadraticDiscriminantAnalysis() # Calcul 2 CHOSES : facteurs principaux et méthode d'analyse linéaire discriminantes
qda.fit(X,y)
yhat = qda.predict(X)
errl=100*np.count_nonzero(y!=yhat)/len(y)
print("Taux d'erreur: ",round(errl,3),"%")
print("")

plt.rcParams.update({'figure.figsize': (3,3),'font.size': 16})
conf_mat =  confusion_matrix(y,yhat)
ConfusionMatrixDisplay(conf_mat).plot(cmap='YlOrBr',colorbar=False)
plt.title("Quadratique")
plt.rcdefaults()

# Avec validation croisée : Quadratique

ntest=np.floor(len(y)/3).astype(int)
errl = 0
i = 0
while i < i_max:
  per=np.random.permutation(len(y))
  lt,la=per[:ntest], per[ntest:]
  Xa,Xt=X[la,:],X[lt,:]
  ya,yt=y[la],y[lt]
  qda.fit(Xa,ya)
  yhat = qda.predict(Xt)
  errl += 100*np.count_nonzero(yt!=yhat)/len(yt)
  i += 1
errl /= i_max
print("======= Validation croisée : Quadratique =======")
print("Taux d'erreur: ",round(errl,3),"%")
print("")
print("")
print("")
print("")


































# ACP puis Quadratique
print("======= ACP puis Quadratique =======")

(U,D,VT) = np.linalg.svd(X,full_matrices=False)
V=VT.T 

Erreur_apprentissage_total_qda = []
Erreur_croisée_qda = []

Erreur_apprentissage_total_lda = []
Erreur_croisée_lda = []

Min = 1
Max = 40
for taille in range(Min,Max+1):
  print("============================================")
  print("Nombre de composantes principales : ",taille)
  X_transform = np.array([(D[i]*U[:,i]) for i in range(taille)]).T


  print("     "+"========= Linéaire =========")
  print(2*"     "+"Sans validation croisée : Linéaire")
  lda = LinearDiscriminantAnalysis() # Calcul 2 CHOSES : facteurs principaux et méthode d'analyse linéaire discriminantes
  lda.fit(X_transform,y)
  yhat = lda.predict(X_transform)
  errl=100*np.count_nonzero(y!=yhat)/len(y)
  print(3*"     "+"Taux d'erreur: ",round(errl,3),"%\n")
  Erreur_apprentissage_total_lda.append(errl)

  # Avec validation croisée : Linéaire Synthétique
  print(2*"     "+"Avec validation croisée : Linéaire Synthétique")

  ntest=np.floor(len(y)/3).astype(int)
  errl = 0
  i = 0
  while i < i_max:
    per=np.random.permutation(len(y))
    lt,la=per[:ntest], per[ntest:]
    Xa,Xt=X_transform[la,:],X_transform[lt,:]
    ya,yt=y[la],y[lt]
    lda.fit(Xa,ya)
    yhat = lda.predict(Xt)
    errl += 100*np.count_nonzero(yt!=yhat)/len(yt)
    i += 1
  errl /= i_max
  print(3*"     "+"Taux d'erreur de validation croisée: ",round(errl,3),"%\n")
  Erreur_croisée_lda.append(errl)




  print("     "+"========= Quadratique =========")
  print(2*"     "+"Sans validation croisée : Quadratique")
  qda = QuadraticDiscriminantAnalysis() # Calcul 2 CHOSES : facteurs principaux et méthode d'analyse linéaire discriminantes
  qda.fit(X_transform,y)
  yhat = qda.predict(X_transform)
  errl=100*np.count_nonzero(y!=yhat)/len(y)
  print(3*"     "+"Taux d'erreur: ",round(errl,3),"%\n")
  Erreur_apprentissage_total_qda.append(errl)

  # Avec validation croisée : Quadratique Synthétique
  print(2*"     "+"Avec validation croisée : Quadratique Synthétique")

  ntest=np.floor(len(y)/3).astype(int)
  errl = 0
  i = 0
  while i < i_max:
    per=np.random.permutation(len(y))
    lt,la=per[:ntest], per[ntest:]
    Xa,Xt=X_transform[la,:],X_transform[lt,:]
    ya,yt=y[la],y[lt]
    qda.fit(Xa,ya)
    yhat = qda.predict(Xt)
    errl += 100*np.count_nonzero(yt!=yhat)/len(yt)
    i += 1
  errl /= i_max
  print(3*"     "+"Taux d'erreur de validation croisée: ",round(errl,3),"%\n\n")
  Erreur_croisée_qda.append(errl)


fig, axs = plt.subplots(1, 2)
fig.suptitle('ACP puis Quadratique')
fig.set_figheight(7)
fig.set_figwidth(15)

axs[0].plot(Erreur_apprentissage_total_qda,label="Erreur d'apprentissage")
axs[0].plot(Erreur_croisée_qda,label="Erreur de validation croisée")
axs[0].set_xticks(list(np.arange(Min,Max+1,2)))
axs[0].set_xlabel("Nombre de composantes principales")
axs[0].set_ylabel("Taux d'erreur (%)")
axs[0].legend()

axs[1].plot(Erreur_apprentissage_total_qda[3:],label="Erreur d'apprentissage")
axs[1].plot(Erreur_croisée_qda[3:],label="Erreur de validation croisée")
axs[1].set_xticks(list(np.arange(0,Max-Min-2,2)),list(np.arange(Min+3,Max+1,2)))
axs[1].set_xlabel("Nombre de composantes principales")
axs[1].set_ylabel("Taux d'erreur (%)")
axs[1].legend()


fig1, axs = plt.subplots(1, 2)
fig1.suptitle('ACP puis Linéaire')
fig1.set_figheight(7)
fig1.set_figwidth(15)

axs[0].plot(Erreur_apprentissage_total_lda,label="Erreur d'apprentissage")
axs[0].plot(Erreur_croisée_lda,label="Erreur de validation croisée")
axs[0].set_xticks(list(np.arange(Min,Max+1,2)))
axs[0].set_xlabel("Nombre de composantes principales")
axs[0].set_ylabel("Taux d'erreur (%)")
axs[0].legend()

axs[1].plot(Erreur_apprentissage_total_lda[3:],label="Erreur d'apprentissage")
axs[1].plot(Erreur_croisée_lda[3:],label="Erreur de validation croisée")
axs[1].set_xticks(list(np.arange(0,Max-Min-2,2)),list(np.arange(Min+3,Max+1,2)))
axs[1].set_xlabel("Nombre de composantes principales")
axs[1].set_ylabel("Taux d'erreur (%)")
axs[1].legend()
plt.show()