#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 12 08:28:18 2018

@author: valerie
"""

import numpy as np
from sklearn.cluster import  KMeans
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix,ConfusionMatrixDisplay

# Chargement des données ======================================================
path="/home/maenwe/Master_CSM/Master_1/Semestre_2/APST/Etudes/Donnees1/"
digits=np.loadtxt(path+"data.csv",delimiter=',',skiprows=1,usecols=range(1,20532))
labels=np.loadtxt(path+"labels.csv",delimiter=',',skiprows=1,dtype='str',usecols=1)

nclus=3*len(np.unique(labels))
k_means = KMeans(init='k-means++', n_clusters=nclus, n_init=50)

k_means.fit(digits) 
cl = k_means.labels_ 

# Calcul de l'étiquette majoritaire de chaque classe et du taux d'erreur
# On fabrique le tableau maj_lab qui a un nurmero de classe (p.ex. predit)
# renvoie l'etiquette correspondante.
maj_lab=np.array([]) # Initialisation de tableau
for k in range(k_means.n_clusters):
  counts=np.unique(labels[cl==k],return_counts=True) # Nb d'occurences de chaque label
  imax=np.argmax(counts[1]) # Recherche du majoritaire dans k
  maj_lab = np.append(maj_lab, counts[0][imax]) # Son étiquette ya majoritaire dans k

maj_lab1=np.array([maj_lab[0]]) # Initialisation de tableau pour les étiquettes majoritaires avec un suffixe pour les doublons
lab=np.unique(maj_lab)
count_lab = np.zeros(len(lab), dtype=int)

for k in range(1,len(maj_lab)):
  if maj_lab[k] in maj_lab1:
    i_0 = np.where(lab == maj_lab[k])[0][0]
    count_lab[i_0] += 1
    maj_lab1=np.append(maj_lab1,maj_lab[k]+"_"+str(count_lab[i_0]))
  else:
    maj_lab1=np.append(maj_lab1,maj_lab[k])
    count_lab = np.append(count_lab, 1)

print('\n')
print("Classe".ljust(23,'.')+" ",end='')
print(*range(k_means.n_clusters),end='')
print("\n"+"Etiquette majoritaire".ljust(23,'.')+" ",end='')
print(*(maj_lab1))
err=100*sum(labels!=maj_lab[cl])/len(cl)
print("Taux de mal classés:",err.round(3),"%")

pred_labels = maj_lab1[cl]
labels_cm = np.unique(np.concatenate((labels, pred_labels)))
conf_mat = confusion_matrix(labels, pred_labels, labels=labels_cm)
plt.rcParams.update({'figure.figsize': (3,3),'font.size': 10})
ConfusionMatrixDisplay(conf_mat, display_labels=labels_cm).plot(cmap='YlOrBr')
im = plt.gca().images[-1].colorbar.remove()
plt.rcdefaults()
plt.title('{} classes'.format(k_means.n_clusters))

def BarPlotMat(M):
  I=M.shape[0]
  J=M.shape[1]
  ind = np.arange(J)
  haut = 0*M[0,:]
  for i in range(I):
    plt.bar(ind,M[i,:],bottom=haut,color=plt.cm.inferno(i/(I-1)))
    haut += M[i,:]

fig=plt.figure(3)
BarPlotMat(conf_mat)
plt.xlabel('Classe')
plt.ylabel('Répartition des étiquettes')
plt.title('Répartition dans chaque classe')
plt.xticks(np.arange(len(labels_cm)), labels_cm)
plt.title('Répartition dans chaque classe')
plt.legend(labels_cm)
plt.show()