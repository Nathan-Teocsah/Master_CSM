# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
from scipy.cluster.hierarchy import dendrogram, linkage, fcluster
from sklearn.cluster import  KMeans

#### Importation des donnees, noms de fromage et noms de variable
path = "/home/maenwe/Master_CSM/Master_1/Semestre_2/APST/Etudes/Donnees1/"
fromages=np.loadtxt(path+"data.csv",delimiter=',',skiprows=1,usecols=range(1,20532))

nomvar=np.loadtxt(path+"labels.csv",delimiter=',',skiprows=1,dtype='str',usecols=0) # numéro des gênes
nomfrom=np.loadtxt(path+"labels.csv",delimiter=',',skiprows=1,dtype='str',usecols=1) # numéro du patient

##### Exemple de programation de CAH #####
print("\n******* Classification Ascendante hiérarchique ******* \n")

# Calcul de l'arbre
M=linkage(fromages,method='ward',metric='euclidean')

#### Décroissance des variances intraclasse
print("====> Décroissance des variance interclasse")
N = np.flip(M[:,2],axis=0)
print(N)
seuil=int(input("Vous pouvez choisir le seuil de coupe de l'arbre : "))

VI=np.cumsum(M[:,2]**2)/2
plt.figure()
plt.plot(np.arange(1,len(VI)+1),np.flip(VI,axis=0))
plt.yticks(list(np.flip(VI,axis=0)))
plt.xlabel("Nombre de classes")
plt.ylabel("Variance intraclasse")


plt.figure()
x = np.arange(1,len(N)+1)
s = np.min(np.where(N<seuil))
plt.axvline(x[s], linestyle='dashed')
plt.axhline(y=seuil, linestyle='dashed')
plt.plot(x,N)
plt.xticks([x[s],max(x),max(x)//2,max(x)//4,3*max(x)//4,max(x)//8,max(x)//16])
plt.yticks(list(N)+[seuil])
plt.xlabel("Nombre de classes")
plt.ylabel("Delta Distance (Ward)")

# Tracé de l'arbre
print("====> Dendogram\n")
plt.figure()
plt.title('CAH. Visualisation des classes au seuil de '+str(seuil))
d=dendrogram(M,no_labels=True,orientation='right',color_threshold=seuil)

##### Récupération des groupes
print("====> Récupération des groupes")
groupes=fcluster(M,t=seuil,criterion='distance')
"""
for k in range(1,np.max(groupes)+1):
    print('Classe '+str(k).ljust(3,' ')+': ', end='')
    print(*nomfrom[np.where(groupes==k)])
"""

print("\n******* Kmeans ******* \n")

# Comparaison avec les Kmeans
nclus=np.max(groupes)
k_means = KMeans(init='k-means++', n_clusters=nclus, n_init=10)
k_means.fit(fromages)
"""
for k in range(nclus):
    print('Classe '+str(k+1).ljust(3,' ')+': ', end='')
    print(*nomfrom[np.where(k_means.labels_==k)])
"""

print("\n******* Comparaison des inerties ******* \n")

print("Inertie Kmeans",nclus,"centres: ",k_means.inertia_)
print("Inertie CAH",nclus,"classes: ",VI[-nclus])
plt.show()