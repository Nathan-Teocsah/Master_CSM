#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Donnees: https://perso.univ-rennes1.fr/bernard.delyon/tp/Auteurs.csv
# Donnees: https://perso.univ-rennes1.fr/bernard.delyon/tp/AuteursNat.csv

import numpy as np

X = np.loadtxt("Auteurs.csv",delimiter=" ",dtype=str)
Auteurs=X[2:,0]
Gram=X[1,1:]
Mots =X[0,1:]
X=X[2:,1:].astype(float)
Nat=np.loadtxt("AuteursNat.csv",delimiter=",",skiprows=1,usecols=[1])
