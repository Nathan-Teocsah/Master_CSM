# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
from scipy.cluster.hierarchy import dendrogram, linkage, fcluster
from sklearn.cluster import  KMeans
from sklearn.metrics import confusion_matrix,ConfusionMatrixDisplay

#### Importation des donnees, noms de fromage et noms de variable
path = "/home/maenwe/Master_CSM/Master_1/Semestre_2/APST/Etudes/Donnees1/"
fromages=np.loadtxt(path+"data.csv",delimiter=',',skiprows=1,usecols=range(1,20532))
nom_cancer=np.loadtxt(path+"labels.csv",delimiter=',',skiprows=1,dtype='str',usecols=1) # nom du cancer 

##### Exemple de programation de CAH #####
print("\n******* Classification Ascendante hiérarchique ******* \n")

# Calcul de l'arbre
M=linkage(fromages,method='ward',metric='euclidean')

#### Décroissance des variances intraclasse
print("====> Décroissance des variance interclasse")
N = np.flip(M[:,2],axis=0)

diff_max = np.max(-N[1:] + N[:-1])
diff = (-N[1:] + N[:-1])/diff_max
print("Delta distance relative entre...")
for i in range(len(diff)):
  if diff[i] > 0.1:
    print("les classes ",i," et ",i+1," : ",round(diff[i],3), " delta : ",round(N[i],0))

seuil=int(input("Vous pouvez choisir le seuil de coupe de l'arbre : "))
x = np.arange(1,len(N)+1)
s = np.min(np.where(N<seuil))

VI=np.cumsum(M[:,2]**2)/2
plt.figure()
plt.axvline(x[s], linestyle='dashed')
plt.axhline(y=VI[len(N)-s-1], linestyle='dashed')
plt.plot(np.arange(1,len(VI)+1),np.flip(VI,axis=0))
plt.yticks(list(np.flip(VI,axis=0)))
plt.xticks([x[s],max(x),max(x)//2,max(x)//4,3*max(x)//4,max(x)//8,max(x)//16])
plt.xlabel("Nombre de classes")
plt.ylabel("Variance intraclasse")


plt.figure()
plt.axvline(x[s], linestyle='dashed')
plt.axhline(y=seuil, linestyle='dashed')
plt.plot(x,N)
plt.xticks([x[s],max(x),max(x)//2,max(x)//4,3*max(x)//4,max(x)//8,max(x)//16])
plt.yticks(list(N))
plt.xlabel("Nombre de classes")
plt.ylabel("Delta Distance (Ward)")

##### Récupération des groupes
print(" ")
print("====> Récupération des groupes")
groupes=fcluster(M,t=seuil,criterion='distance')

maj_lab=np.array([]) # Initialisation de tableau

for k in range(1,len(np.unique(groupes))+1):
  counts=np.unique(nom_cancer[groupes==k],return_counts=True) # Nb d'occurences de chaque label
  imax=np.argmax(counts[1]) # Recherche du majoritaire dans k
  maj_lab = np.append(maj_lab, counts[0][imax]) # Son étiquette ya majoritaire dans k

maj_lab1=np.array([maj_lab[0]]) # Initialisation de tableau pour les étiquettes majoritaires avec un suffixe pour les doublons
pareil=maj_lab[0]
count=0
for k in range(1,len(maj_lab)):
  if maj_lab[k]==pareil:
    count+=1
    maj_lab1=np.append(maj_lab1,maj_lab[k]+"_"+str(count))
  else:
    count=0
    maj_lab1=np.append(maj_lab1,maj_lab[k])
    pareil=maj_lab[k]

  

print('\n')
print("Classe".ljust(23,'.')+" ",end='')
print(*range(len(np.unique(groupes))),end='')
print("\n"+"Etiquette majoritaire".ljust(23,'.')+" ",end='')
print(*(maj_lab1))
err=100*sum(nom_cancer!=maj_lab[groupes-1])/len(groupes)
print("Taux de mal classés:",err.round(3),"%")

pred_labels = maj_lab1[groupes-1]
labels_cm = np.unique(np.concatenate((nom_cancer, pred_labels)))
conf_mat = confusion_matrix(nom_cancer, pred_labels, labels=labels_cm)
plt.rcParams.update({'figure.figsize': (3,3),'font.size': 10})
ConfusionMatrixDisplay(conf_mat, display_labels=labels_cm).plot(cmap='YlOrBr')
im = plt.gca().images[-1].colorbar.remove()
plt.rcdefaults()

# Tracé de l'arbre
plt.figure()
plt.title('CAH. Visualisation des classes au seuil de '+str(seuil))
d=dendrogram(M,no_labels=True,orientation='right',color_threshold=seuil)

ordre_feuilles = d['leaves']
pos_y = {idx: 5 + 10*i for i, idx in enumerate(ordre_feuilles)}

for k in range(1, len(np.unique(groupes)) + 1):
  feuilles_k = np.where(groupes == k)[0]
  y_k = [pos_y[idx] for idx in feuilles_k if idx in pos_y]
  if len(y_k) == 0:
    continue
  y_milieu = np.mean(y_k)
  plt.text(seuil * 1.02, y_milieu, str(maj_lab1[k-1]), va='center', fontsize=9)

plt.axvline(x=seuil, linestyle='dashed', color='gray', linewidth=1)



def BarPlotMat(M):
# Fait un barplot pour chaque colonne de M.
# La couleur correspond à l'indice, la hauteur à la valeur
  I=M.shape[0]
  J=M.shape[1]
  ind = np.arange(J)
  haut = 0*M[0,:]
  for i in range(I):
    plt.bar(ind,M[i,:],bottom=haut,color=plt.cm.inferno(i/(I-1)))
    haut += M[i,:]

plt.figure()
BarPlotMat(conf_mat)
plt.xlabel('Classe')
plt.ylabel('Répartition des étiquettes')
plt.title('Répartition dans chaque classe')
plt.xticks(np.arange(len(labels_cm)), labels_cm)
plt.title('Répartition dans chaque classe')
plt.legend(labels_cm)

plt.show()