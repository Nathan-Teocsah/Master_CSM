#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Dec  7 17:44:34 2020

@author: delyon

"""

import numpy as np

# Adresse des deux fichiers de donnees
# https://perso.univ-rennes1.fr/bernard.delyon/tp/Vent.csv
# https://perso.univ-rennes1.fr/bernard.delyon/tp/Vagues.csv

etudiant = 14003508
 # nombre à remplacer par votre numéro d'etudiant
np.random.seed(etudiant)

# Lecture des donnees
nomvar=np.loadtxt("WindSpeed.csv",delimiter=',',dtype='str',max_rows=1)[1:]
X=np.loadtxt("WindSpeed.csv",delimiter=',',skiprows=1,usecols=1+np.arange(len(nomvar)))
y=np.loadtxt("Hs.csv",delimiter=',',skiprows=1,usecols=1)
n=len(y)

# On extrait un sous-ensemble d'individus
select=np.random.choice(n,size=n//8, replace=False)
X=X[select,:]
y=y[select]
n=n=len(y)
