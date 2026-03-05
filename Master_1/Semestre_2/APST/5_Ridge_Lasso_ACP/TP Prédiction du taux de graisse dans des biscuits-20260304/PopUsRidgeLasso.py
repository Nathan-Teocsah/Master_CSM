#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Feb 12 19:20:14 2021

@author: delyon

On va prédire la population des Etats-Unis en fonction du temps
par régression polynomiale.

"""
import numpy as np
import matplotlib.pyplot as plt
# Population des Etats-Unis entre 1900 et 2000 (une donnees tous les 10 ans)
# mesurée en millions d'habitants.
pop = np.array([75.995, 91.972, 105.711, 123.203, 131.669,
        150.697, 179.323, 203.212, 226.505, 249.633, 281.422])
annees = np.arange(1900,2010,10)
plt.figure(1)
plt.clf()
plt.plot(annees,pop,'k.')
plt.title("Population des Etats-Unis")
plt.xlabel("Annee")
plt.ylabel("Population (millions d'habitants)")

x = (annees-1950) /100 # Les instants d'observation sur une éechelle de -1 à 1
mois = np.arange(1890,2020,1./12) # Les mois sur l'échelle année (pour tracés)
xfin = (mois-1950) /100 # Les mois sur l'échelle de -1 à 1 (pour tracés)
y=pop.copy()
degre_max = 9
X = np.zeros([len(x),degre_max])
Xfin = np.zeros([len(xfin),degre_max]) # Tableau pour prédiction tous les mois
for j in range(degre_max):  # La colonne de 1 sera ajoutée par scikitlearn
  X[:,j] = x**(j+1)
  Xfin[:,j] = xfin**(j+1)
#from sklearn.preprocessing import StandardScaler
#scl=StandardScaler()
#X=scl.fit_transform(X)
#Xfin=scl.transform(Xfin)
#
#  =========================================================
# Régression linéaire
# On approche l'évolution de la population par un polynome
# de degré de plus en plus élévé.
#
# Tracé des polynômes
from sklearn.linear_model import LinearRegression
lr = LinearRegression()
plt.figure()
plt.subplots_adjust(hspace=.7,wspace=.5)
plt.suptitle('Regression OLS à divers degrés')
c=np.zeros(degre_max)
for j in range(1,degre_max+1):
     lr.fit(X[:,:j],y)
     yfin = lr.predict(Xfin[:,:j])
     plt.subplot(3,3,j)
     plt.plot(x,y,'k.',xfin,yfin,'r--')
     plt.title("Degré= "+str(j))
     c[j-1]=np.sum(lr.coef_**2)
# Evolution de la norme des coefficients en fct du degré
plt.figure()
plt.title(r"Evolution de la norme des coefficients ($\log_{10}$) en fct du degré")
plt.plot(np.log(c)/np.log(10))
plt.plot(np.log(c)/np.log(10),'ro')
plt.show()
# ============================================================
# Régression Ridge
# Pour choisir visuellement la constante de regularisation
# on construit une grille de valeurs pour alpha,
# on observe l'ajustement.
# La validation croisée faite plus bas donnera un résultat plus fiable.
from sklearn.linear_model import Ridge
alphas =  10.**np.arange(-8,3)
plt.figure()
plt.suptitle('Regressions ridge')
plt.subplots_adjust(hspace=.7,wspace=.5)
norbet=np.zeros(len(alphas))
rmse=np.zeros(len(alphas))
for j,a in enumerate(alphas):
    reg = Ridge(alpha=a)
    reg.fit(X,y)
    norbet[j]=np.sqrt(np.sum(reg.coef_**2))
    rmse[j]=np.sqrt(np.mean((reg.predict(X)-y)**2))
    yfin = reg.predict(Xfin)
    plt.subplot(int(len(alphas)/4+.99),4,j+1)
    plt.plot(x,y,'k.',xfin,yfin,'r-')
    plt.title(r"$\alpha$="+str(a))
# L'évolution de la norme de beta et du RMSE donne aussi une idée du bon alpha.
plt.subplots()
plt.semilogx()
plt.title('Ridge. Norme de de beta (rond) et RMSE (croix)')
plt.plot(alphas,norbet,'r')
plt.plot(alphas,norbet,'ro',label="|beta|")
plt.legend(loc='center left')
plt.twinx()
plt.plot(alphas,rmse,'b')
plt.plot(alphas,rmse,'bx',label="RMSE")
plt.legend(loc='center right')
# ============================================================
# Régression Lasso
# Il se trouve que la même grille peut être utilisée
# Même procédure que précédemment
from sklearn.linear_model import LassoLars
plt.figure()
plt.suptitle('Regressions lasso')
plt.subplots_adjust(hspace=.7,wspace=.5)
alphas =  10.**np.arange(-8,3)
nco=alphas*0.
for j,a in enumerate(alphas):
    reg = LassoLars(alpha=a)
    reg.fit(X,y)
    nco[j]=sum(abs(reg.coef_)>1.e-16)
    rmse[j]=np.sqrt(np.mean((reg.predict(X)-y)**2))
    plt.subplot(int(len(alphas)/4+.99),4,j+1)
    plt.plot(x,y,'k.',xfin,reg.predict(Xfin),'r-')
    plt.title(r"$\alpha$="+str(a))
    plt.axis([np.min(xfin),np.max(xfin),np.min(y)*.9,np.max(y)*1.1])
# Nombre de coefficients non nuls et RMSE
plt.subplots()
plt.semilogx()
plt.title('Lasso. Nb de coeff non nuls (rond) et RMSE (croix)')
plt.plot(alphas,nco,'r')
plt.plot(alphas,nco,'ro',label=r"Nb$\ne$0")
plt.legend(loc='center left')
plt.twinx()
plt.plot(alphas,rmse,'b')
plt.plot(alphas,rmse,'bx',label="RMSE")
plt.legend(loc='center right')
# ============================================================
#  Choix de la constante de regularisation du ridge par validation croisee
# B est le nombre de tirages.
B = 30
ntest=3
alphas = 10.**np.arange(-8,3) # reajuster ?????
mse = np.zeros(len(alphas))
for b in range(B):
  per = np.random.permutation(X.shape[0])
  lt, la = per[:ntest], per[ntest:]
  Xa,ya =X[la,:], y[la]
  Xt,yt =X[lt,:], y[lt]
  for j,a in enumerate(alphas):
    reg = Ridge(alpha=a)
    reg.fit(Xa,ya)
    yh = reg.predict(Xt)
    mse[j]+=np.mean((yh-yt)**2)
mse=mse/B
rmse=np.sqrt(mse)
plt.figure()
plt.suptitle(r'Ridge. RMSE par validation croisée pour divers $\alpha$.')
plt.semilogx()
plt.plot(alphas,rmse,alphas,rmse,'ro')
plt.show()
rmseridge=rmse
print('Minimum Ridge CV RMSE=',min(rmseridge).round(2))
# ============================================================
#  Choix de la constante de regularisation du ridge par LOO
#???????????????????????
#???????????????????????

# ============================================================
#  Choix de la constante de regularisation du lasso par validation croisee
#???????????????????????
#???????????????????????

print('#################################')
# ============================================================
#  Choix de la constante de regularisation du  lasso par LOO
#???????????????????????
#???????????????????????

print('Minimum Ridge CV RMSE=',min(rmseridge).round(2))
print('Minimum Ridge LOO RMSE=','???')
print('Minimum Lasso CV RMSE=','???')
print('Minimum Lasso LOO RMSE=','???')



