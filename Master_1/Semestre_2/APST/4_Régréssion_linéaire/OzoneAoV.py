#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 25 17:59:50 2021

@author: delyon
"""
# Exemple de fabrication d'une table d'analyse de variance
# Il faudra utiliser la fonction ols de la bibliothèque stasmodels qui fait la régression.
# L'argument de la fonction n'est pas (X,y) mais une dataframe (billiothèque pandas), structure de donnée qui est un tableau individus/variables avec des méthodes permettant de faire facilement des manipulations classiques, en particulier un accès direct aux variables par leur nom.

# Lecture des données

import pandas
d = pandas.read_csv('Ozone.txt', sep=' ')
d.head()

# Regression et affichage du tableau summary
# On voit bien le R2, les coefficients estimés et leur incertitude.

import statsmodels.api as sm
from statsmodels.formula.api import ols
f='maxO3 ~ maxO3v+vent+pluie+T9+T12+T15+Vx9+Vx12+Vx15'
mod = ols(formula=f, data=d).fit()
print(mod.summary())

# Obtenir des p-values globales aux variables catégorielles
# En effet les p-values ci-dessus (colonne P>|T|) sont données colonne de X par colonne de X, et non pas variable par variable, ce qui n'a pas beaucoup de sens (on met le vent ou ne le met pas...). Il faut alors appeler la fonction anova.

#On voit que maxO3v joue une rôle indiscutable dans la prédiction. En revanche, la direction du vent n'a pas d'influence significative.

anova_table = sm.stats.anova_lm(mod, typ=3)
print(anova_table)
print("\nOn va retirer en premier T9. \nOn voit que maxO3v joue un grand role")
