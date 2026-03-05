#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun 28 10:04:48 2018
@author: valerie
"""

import numpy as np
import matplotlib.pyplot as plt
biscuits=np.loadtxt("Biscuits.csv",skiprows=1,delimiter=";")
# Extraction de la colonne fat
fat=biscuits[:,0]
# Extraction des variables explicatives
X=biscuits[:,1:]
# Trace d'un spectre
plt.figure(1)
plt.plot(X[1,:])
plt.title("Un exemple de spectre")
# Trace des spectres avec la couleur wqui varie selon le taux de graisse
fatn = fat-min(fat);
fatn=fatn/max(fatn)
colors= plt.cm.inferno(fatn)
plt.figure(2)
for i in range(len(fat)):
   plt.plot(X[i,:],color=colors[i])
plt.title("Spectres NIR")
plt.ylabel("Absorbances")
plt.show()
plt.figure(3)
s=np.mean(X,axis=0)
for i in range(len(fat)):
   plt.plot(X[i,:]-s,color=colors[i])
plt.title("Spectres NIR recentrés")
plt.ylabel("Absorbances")
plt.show()


