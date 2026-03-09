#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ACP
"""
import numpy as np
import matplotlib.pyplot as plt

# Par defaut
labels=None
indiv=[]
varbs=None

# Lecture des donnees de data.csv : possède 802 lignes et 20 532 colonnes 
# la première colonne contient le nom de l'échantillon (il y en a 801)
# la première ligne contient le nom des variables : c'est le nom du gêne (gêne_0, etc.), i y en a 20 531
path = "/home/maenwe/Master_CSM/Master_1/Semestre_2/APST/Etudes/Donnees1/"
X=np.loadtxt(path+"data.csv",delimiter=',',skiprows=1,usecols=range(1,20532))
indiv=np.loadtxt(path+"labels.csv",delimiter=',',skiprows=1,dtype='str',usecols=0) # numéro des gênes
labels=np.loadtxt(path+"labels.csv",delimiter=',',skiprows=1,dtype='str',usecols=1) # nom du cancer (il y a pleins de doublons)


# Récupère le noms des gênes
#varbs=np.loadtxt("data.csv",dtype='str',delimiter=',')[0,1:] 



def stdise(X):
  Xs=X.astype(float) # Pour etre sur que Xs est en float, utilité ? Car np.loadtxt renvoie déjà un float
    # Pas utile

  mk=np.mean(Xs,axis=0) # axis = 0 : moyenne de chaque colonne
  # Calcul de l'ecart-type avec max pour eviter une division par 0
  sk=np.maximum(np.std(Xs,axis=0),10*np.finfo(float).eps) 
    # np.finfo(float) donne des infos sur le type float et .eps est la plus petite valeur representable en float
    # np.std : ecart type (standard deviation)
    # Ce n'est pas le maximum du tableau !!!!
    # Cette fonction fait le max entre chaque élément du tableau (écart type)
    # et le 2ème argument (10*eps)

  Xs=(X-mk)/sk
  return Xs
  # IL n'est pas utile de renvoyer mk et sk 

# SVD. Axes Composantes 
# Apres standardisation les colonnes sont de norme "nb de ligne" et non 1, 
# on corrige cela, pour avoir de meilleures echelles. 
Xs=stdise(X)


(U,D,VT) = np.linalg.svd(Xs,full_matrices=False) 

V=VT.T # Transposée de VT 
# Premieres composantes principales : on prend les première car les vp sont, par défaut, rangés par ordre décroissant 
C1 = D[0]*U[:,0] 
C2 = D[1]*U[:,1] 
C3 = D[2]*U[:,2] # Pourquoi le sortir ? 
# Axes principaux modifies pour le cercle des correlations 
# On veut faire en sorte que le vecteur associé à 
# la plus grande valeur propre soit de norme 1, 
# étant donné qu'on a nomalisé chaque X[i,:] (avec stdin(X)), 
# la somme des normes des X[i,:] est égale au nombre de lignes de X 
# Or les valeurs propres sont les racines carrées des inerties (sommes de x_i au carré) 
A1 = D[0]*V[:,0]/np.sqrt(np.shape(X)[0]) 
A2 = D[1]*V[:,1]/np.sqrt(np.shape(X)[0]) 


# Graphiques premier plan factoriel
plt.close('all')
plt.figure()
plt.title('Representation des individus dans le plan (C1,C2)')

vlab=np.unique(labels) # Détruit les doublons
for i,vl in enumerate(vlab): # permet de récupérer les valeurs de vlab et les indices de ces valeurs
  l=labels==vl # affiche dans un vecteur les éléments de labels qui valent vl (permettant de ne récupérer que les combinaison linéaire correspondant au four vl)
  plt.scatter(C1[l],C2[l],s=47,label=vl) # permet d'afficher les courbes C1 et C2 correspondant au four vl, s=47 correspond à l'aire (en pt^2) des points
plt.legend(title="Cancers")
plt.xlabel(f'C1 ({100*D[0]**2/sum(D**2):.2f}%)')
plt.ylabel(f'C2 ({100*D[1]**2/sum(D**2):.2f}%)')


# Graphiques deuxième plan factoriel
plt.figure()
plt.title('Representation des individus dans le plan (C2,C3)')
if labels is None:
  plt.scatter(C2,C3)
else:
  vlab=np.unique(labels) # Détruit les doublons
  lv=len(vlab)
  #cols=['C0','C1','C2','C3','k'] # un choix de couleurs
  #cols=plt.cm.nipy_spectral(np.arange(lv)/lv) # un choix de couleurs
  for i,vl in enumerate(vlab): # permet de récupérer les valeurs de vlab et les indices de ces valeurs
    l=labels==vl # affiche dans un vecteur les éléments de labels qui valent vl (permettant de ne récupérer que les combinaison linéaire correspondant au four vl)
    plt.scatter(C2[l],C3[l],s=47,label=vl) # permet d'afficher les courbes C2 et C3 correspondant au four vl, s=47 correspond à l'aire (en pt^2) des points
  plt.legend(title="Cancers")
plt.xlabel(f'C2 ({100*D[1]**2/sum(D**2):.2f}%)')
plt.ylabel(f'C3 ({100*D[2]**2/sum(D**2):.2f}%)')

#A partir de combien de variable on est à 95% de l'inertie ?
print("A partir de combien de variable on est à 95% de l'inertie ?")
i0 = np.where(100*np.cumsum(np.square(D))/sum(D**2)>95)[0][0]+1
print(i0) 

print("Dernières Valeurs singulières :", D[-5:])

# Inerties
plt.figure()
plt.plot(100*np.cumsum(np.square(D))/sum(D**2))
plt.axvline(x=i0, linestyle='dashed')
plt.axhline(y=95, linestyle='dashed')
plt.yticks(np.arange(0,101,20).tolist() + [95])
plt.title('Inerties cumulées en %')
plt.xlabel('Nombre de composantes principales')

plt.figure()
plt.bar(np.arange(100,np.shape(D)[0])+1, 100*np.cumsum(np.square(D))[100:]/sum(D**2))
plt.title('Inerties cumulatives en %')
plt.xlabel('Nombre de composantes principales')

plt.show()