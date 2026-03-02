#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Donnees: https://perso.univ-rennes1.fr/bernard.delyon/tp/KeyboardData1.csv

import numpy as np

print("N'oubliez pas de mettre votre numero d'etudiant") 
etudiant = 100 # nombre à remplacer par votre numéro d'etudiant
np.random.seed(etudiant)

# Lecture des donnees
nomvar=np.loadtxt("KeyboardData1.csv",delimiter=',',dtype='str',max_rows=1)[1:]
key=np.loadtxt("KeyboardData1.csv",delimiter=',',skiprows=1)

# Le tableau individus/variables et le vecteur des numeros de sujet pour chaque individu
X=key[:,1:]
y=key[:,0].astype(int) 
slist=np.unique(y)
ns=len(slist) # nombre de sujets 
print('Il y a ',ns, 'sujets')
ne=sum(y==2) 
print("Nombre d'essais pour chaque sujet:\n",[sum(y==l) for l in slist])
print('Il y a ',X.shape[1],'mesures pour chaque essai')

# On extrait désormais la moitié des essais de chacun
per=np.random.choice(ne,size=ne//2, replace=False)
select=np.tile(per,ns)+np.repeat(np.arange(ns)*ne,ne//2)
X=X[select,:]
y=y[select]
print("Nombre d'essais pour chaque sujet apres selection:\n",[sum(y==l) for l in slist])

