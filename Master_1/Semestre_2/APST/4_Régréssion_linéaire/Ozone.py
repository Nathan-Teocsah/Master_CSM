#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue May 22 11:52:30 2018

@author: delyon
"""

import numpy as np
from sklearn.linear_model import LinearRegression

# Data importation
# On lit le tableau comme un tableau de chaînes de caractères,
# on extrait les colonnes numériques,
# on fabrique artisanalement les dummies avec les colonnes catégorielles,
# on reconstitue le tout.
Ozone = np.loadtxt("Ozone.txt",skiprows=1,dtype=np.ndarray)
nomvar=np.loadtxt("Ozone.txt",dtype='str')[0,:][1:]
y=Ozone[:,1].astype(float)
y.shape
X=Ozone[:,2:-2].astype(float)
vent=Ozone[:,[-2]]
VO=(vent=='Ouest')*1.
VS=(vent=='Sud')*1.
VE=(vent=='Est')*1.
P=(Ozone[:,[-1]]=='Pluie')*1.
X0=np.concatenate((X,VO,VE,VS,P),axis=1)
# Noms des variables explicatives
nomvar=np.concatenate((nomvar[1:-2],["Ouest"],["Sud"],["Est"],["Pluie"]))
# Pour l'instant on prend toutes les variables:
X=X0
#### Estimation du premier modèle linéaire avec scikitlearn
# --->  Calculer les coeff et les afficher
# ---> Calculer le MSE
reg = LinearRegression()
reg.fit(X,y)
yhat=reg.predict(X)
MSE=sum((yhat-y)**2)/len(y)
print('MSE = ',MSE.round(2))
print('RMSE = ',np.sqrt(MSE).round(2))
#### Calcul de l'erreur par validation croisée
# LLO
MSELOO=0
for i in range(len(y)):
  Xa, Xt = np.delete(X,i,axis=0), X[[i],:]
  ya, yt = np.delete(y,i), y[i]
  reg.fit(???)
  yhat=reg.predict(???)
  MSELOO+=???
print('RMSE LOO = ',)
# 5-Fold
MSECV=0
it=3000
ntest=len(y)//5
for i in range(it):
  per = np.random.permutation(X.shape[0])
  lt, la = per[:ntest], per[ntest:]
  Xa, Xt = X[la,:], X[lt,:]
  ya, yt = y[la], y[lt]
  reg.fit(???)
  yhat=reg.predict(???)
  MSECV+=np.mean((yhat-yt)**2)
print('RMSE  CV 1/5  = ',)

#### Pour le calcul sans vent ni pluie
X=X0[:,(nomvar!="Ouest")&(nomvar!="Est")&(nomvar!="Sud")&(nomvar!="Pluie")]
# etc.
