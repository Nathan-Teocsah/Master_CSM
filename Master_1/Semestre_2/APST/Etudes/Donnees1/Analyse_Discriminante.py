#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Mar 25 09:11:35 2018

@author: valerie
"""


# importation des données -----------------------------------------------------
import numpy as np
import matplotlib.pyplot as plt
# importation des données -----------------------------------------------------

path = "/home/maenwe/Master_CSM/Master_1/Semestre_2/APST/Etudes/Donnees1/"
X=np.loadtxt(path+"data.csv",delimiter=',',skiprows=1,usecols=range(1,20532))
nomvar=np.loadtxt(path+"labels.csv",delimiter=',',skiprows=1,dtype='str',usecols=0) # numéro des gênes
y=np.loadtxt(path+"labels.csv",delimiter=',',skiprows=1,dtype='str',usecols=1) # nom du cancer (il y a pleins de doublons)

# Analyse discriminante linéaire ----------------------------------------------
print("======= Analyse discriminante linéaire =======")
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.metrics import confusion_matrix,ConfusionMatrixDisplay
lda = LinearDiscriminantAnalysis() # Calcul 2 CHOSES : facteurs principaux et méthode d'analyse linéaire discriminantes
lda.fit(X,y)
yhat = lda.predict(X)
errl=sum(y!=yhat)/len(y)

print("Taux d'erreur: ",round(errl,3))

plt.rcParams.update({'figure.figsize': (3,3),'font.size': 16})
conf_mat =  confusion_matrix(y,yhat)
ConfusionMatrixDisplay(conf_mat).plot(cmap='YlOrBr',colorbar=False)
plt.rcdefaults()

# Premier plan factoriel
C = lda.fit_transform(X, y)# On a 5 classes, donc 4 facteurs principaux
C1 = C[:,0] # Premier facteur principal
C2 = C[:,1] # Deuxième facteur principal
C3 = C[:,2] # Troisième facteur principal
C4 = C[:,3] # Quatrième facteur principal

plt.figure()

plt.subplot(2,3,1)
plt.xlabel("C1")
plt.ylabel("C1")

plt.subplot(2,3,2)
plt.xlabel("C1")
plt.ylabel("C2")
vlab=np.unique(y) # Détruit les doublons
for i,vl in enumerate(vlab): 
  l=y==vl 
  plt.scatter(C1[l],C2[l],s=47,label=vl) 
plt.legend()

plt.subplot(2,3,3)
plt.xlabel("C1")
plt.ylabel("C3")
vlab=np.unique(y) # Détruit les doublons
for i,vl in enumerate(vlab): 
  l=y==vl 
  plt.scatter(C1[l],C3[l],s=47,label=vl) 
plt.legend()

#Ligne 2
plt.subplot(2,3,4)
plt.xlabel("C2")
plt.ylabel("C1")

plt.subplot(2,3,5)
plt.xlabel("C2")
plt.ylabel("C2")

plt.subplot(2,3,6)
plt.xlabel("C2")
plt.ylabel("C3")
vlab=np.unique(y) # Détruit les doublons
for i,vl in enumerate(vlab): 
  l=y==vl 
  plt.scatter(C2[l],C3[l],s=47,label=vl) 
plt.legend()


# Avec validation croisée
"""
ntest=np.floor(len(y)/2).astype(int)
errl = 0
i = 0
while i < 100:
  per=np.random.permutation(len(y))
  lt,la=per[:ntest], per[ntest:]
  Xa,Xt=X[la,:],X[lt,:]
  ya,yt=y[la],y[lt]
  lda.fit(Xa,ya)
  yhat = lda.predict(Xt)
  errl += sum(yt!=yhat)/len(yt)
  i += 1
errl /= 100
print("======= Validation croisée =======")
print("Taux d'erreur: ",round(errl,3))
"""

# Analyse discriminante quadratique ----------------------------------------------
print("======= Analyse discriminante quadratique =======")
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis
lda = QuadraticDiscriminantAnalysis() # Calcul 2 CHOSES : facteurs principaux et méthode d'analyse linéaire discriminantes
lda.fit(X,y)
yhat = lda.predict(X)
errl=sum(y!=yhat)/len(y)
print("Taux d'erreur: ",round(errl,3))
plt.rcParams.update({'figure.figsize': (3,3),'font.size': 16})
conf_mat =  confusion_matrix(y,yhat)
ConfusionMatrixDisplay(conf_mat).plot(cmap='YlOrBr',colorbar=False)
plt.rcdefaults()

plt.show()

