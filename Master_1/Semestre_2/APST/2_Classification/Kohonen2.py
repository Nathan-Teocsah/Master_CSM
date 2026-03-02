# -*- coding: utf-8 -*-
"""
Created on Thu Sep 20 17:32:18 2018

@author: N
"""
################################# Algorithme de Kohonen #################################################################################
from scipy import *
from pylab import *
import random
from math import *
import numpy as np
import matplotlib.pyplot as pl
import time 
import os
from collections import Counter


verbose = False

def carte(n):
    Cart=[]
    l=int(sqrt(n))
    r=0
    for i in range(l):
        C=[]
        for j in range(r,l+r):
            C.append(j+1)
        Cart.append(C)
        r=r+l
    return Cart
    

def dist_top(i,g,cart): #distance topologique par rapport au neurone gagnant sur la carte
    t=len(cart)
    indice_i=[0,0]
    indice_g=[0,0]
    
    for k in range(t):
        for j in range(t):
            if cart[k][j]==i:
                indice_i=[k,j]
            elif cart[k][j]==g:
                indice_g=[k,j]   
    return (abs(indice_i[0]-indice_g[0])+abs(abs(indice_i[1]-indice_g[1])))

def voisinage2(cart,v,g):
    L=[]
    r=len(cart)
    for i in range(r):
        d=dist_top(i,g,cart)
        if d<=v:
            L.append(i)
    return(L)

def voisinage(v, g, n):
     L = []
     for i in range(n):
         d = abs(i - g)
         if d <= v:
             L.append(i)
     return(L)


def voisinage1(v, g, n):
     L = []
     if v + g >= n:
         for i in range(n):
             d = abs(i - g)
             if d <= v:
                 L.append(i)
             elif i < (v + g - (n - 1)):
                 L.append(i)
     elif g - v < 0:
         for i in range(n):
             d = abs(i - g)
             if d <= v:
                 L.append(i)
             elif i > (n - 1 + (g - v)):
                 L.append(i)
     else:
         for i in range(n):
             d = abs(i - g)
             if d <= v:
                 L.append(i)
     return(L)


def voisinage_multiboucles(v, g, tailles_boucles):
     if tailles_boucles is None or len(tailles_boucles) == 0:
         return [g]

     debut = 0
     boucle_g = None
     idx_local_g = None
     taille_boucle_g = None
     for taille in tailles_boucles:
         fin = debut + taille
         if debut <= g < fin:
             boucle_g = (debut, fin)
             idx_local_g = g - debut
             taille_boucle_g = taille
             break
         debut = fin

     if boucle_g is None:
         return [g]

     debut, fin = boucle_g
     L = []
     for idx_local in range(taille_boucle_g):
         d = abs(idx_local - idx_local_g)
         d_circulaire = min(d, taille_boucle_g - d)
         if d_circulaire <= v:
             L.append(debut + idx_local)
     return L


def compet(p, W, n):
     gagnant = 0
     D = W - p
     M = np.sqrt(np.vdot(D[0], D[0]))
     for k in range(n):
         d = D[k]
         norme = np.sqrt(np.vdot(d, d))
         if norme < M:
             M = norme
             gagnant = k
     return gagnant


def tau_ap(t, tau_org, tau, tau_stab):
     if t<=tau:
         return (tau_org - ((tau_org - tau_stab) / tau) * t)
     return tau_stab


def NouveauW(W, t, tau_org, tau, tau_stab, V0, g, p, n, a, tv, cart, tailles_boucles=None): # 'p' correspond à un vecteur choisi dans la base d'apprantisssage. 'V0' lui correspond au voisinnage innitiale
     if t <= tau:
         v =int(V0 * (1 - t / tau))  # On modifie la taille du voisinage à chaque itération
         if a==0:  # Choix du réseau
             L_voisinage = voisinage(v, g, n)  # reseau en ligne
         elif a==1 :
             L_voisinage = voisinage1(v, g, n)  # reseau en boucle
         elif a==2:
             L_voisinage = voisinage2(cart, v, g) # réseau en grilles
         else:
             L_voisinage = voisinage_multiboucles(v, g, tailles_boucles) # réseau en plusieurs boucles
     else:
         L_voisinage = [g]

     tv.append(len(L_voisinage))

     K = tau_ap(t, tau_org, tau, tau_stab)
    
     dif = p - W
     for k in L_voisinage:  # Modification des vecteurs dans W qui sont dans le voisinnage du vecteur gagnat, noté g
         W[k] = W[k] + K * dif[k]
     d=p-W[g]
     norme = np.sqrt(np.vdot(d, d)) 
     return (norme,tv)


def Kohonen(W, n, A, tau, Q, V0, a, melange, cart, tau_org = 0.8, tau_stab = 0.1, tmax= 6, tailles_boucles=None): # La variable 'a' correspond au choix du réseau de neurones, a = True pour celui en ligne et a = False pour celui en boucle
     taille = len(A)
     tv=[]
     t = i = 0
     erreur_glob=0
     erreur_glob_prec=0
     victory = False #il n'acceptait pas les point d'explamation à la fin de victory...
     L_erreur = []
     Photo_W=[]
     while not victory and t<tmax :
         signe = erreur_glob-erreur_glob_prec
         Photo_W.append(np.copy(W))
         erreur_glob_prec=erreur_glob
         erreur_glob = 0
         if melange>=1:
             ordre = np.random.permutation(taille)
         else:
             ordre = np.arange(taille)
         for k in ordre:
             p = A[k]
             g = compet(p, W, n) #Calcul la position du neurone gagnant
             erreur_loc,tv = NouveauW(W, t, tau_org, tau, tau_stab, V0, g, p, n, a, tv, cart, tailles_boucles=tailles_boucles) #Modification de l'ensemble des poids
             erreur_glob=erreur_loc+erreur_glob
         erreur_glob=erreur_glob/taille #moyenne des erreurs locals
         L_erreur.append(erreur_glob)
         t=t+1
         #stabilite_erreur=abs(erreur_glob-erreur_glob_prec)
         if erreur_glob<Q and signe*(erreur_glob-erreur_glob_prec)<0 :
             i = i + 1
         else:
             i = 0
         if i == 3:
             victory = True
     return(t, victory, L_erreur,Photo_W,tv)


def charger_digits(images_path, labels_path):
    images_brut = np.genfromtxt(images_path, delimiter=',', skip_header=1)
    labels_brut = np.genfromtxt(labels_path, delimiter=',', skip_header=1)

    X = images_brut[:, 1:].astype(float)
    y = labels_brut[:, 1].astype(int)

    if X.max() > 1:
        X = X / 255.0

    return X, y


def split_train_test(X, y, ratio_test=0.2, seed=42):
    rng = np.random.default_rng(seed)
    indices = rng.permutation(len(X))
    nb_test = int(len(X) * ratio_test)
    test_idx = indices[:nb_test]
    train_idx = indices[nb_test:]
    return X[train_idx], X[test_idx], y[train_idx], y[test_idx]


def demander_nombre_neurones(defaut=5):
    message = f"Nombre de neurones à utiliser (défaut={defaut}) : "
    try:
        saisie = input(message).strip()
    except EOFError:
        print(f"Aucune saisie détectée, utilisation de la valeur par défaut : {defaut}")
        return defaut

    if saisie == "":
        return defaut

    try:
        n = int(saisie)
    except ValueError:
        print(f"Entrée invalide, utilisation de la valeur par défaut : {defaut}")
        return defaut

    if n <= 0:
        print(f"Le nombre de neurones doit être > 0, utilisation de la valeur par défaut : {defaut}")
        return defaut

    return n


def demander_nombre_affichage(maximum, defaut=7):
    defaut = min(defaut, maximum)
    message = f"Combien de neurones afficher ? (1-{maximum}, défaut={defaut}) : "
    try:
        saisie = input(message).strip()
    except EOFError:
        print(f"Aucune saisie détectée, utilisation de la valeur par défaut : {defaut}")
        return defaut

    if saisie == "":
        return defaut

    try:
        nb = int(saisie)
    except ValueError:
        print(f"Entrée invalide, utilisation de la valeur par défaut : {defaut}")
        return defaut

    if nb <= 0:
        print(f"Le nombre doit être > 0, utilisation de la valeur par défaut : {defaut}")
        return defaut

    if nb > maximum:
        print(f"{nb} dépasse le nombre de neurones ({maximum}), limitation à {maximum}")
        return maximum

    return nb


def demander_nombre_etapes(maximum, defaut=8):
    defaut = min(defaut, maximum)
    message = f"Combien d'étapes d'évolution afficher ? (2-{maximum}, défaut={defaut}) : "
    try:
        saisie = input(message).strip()
    except EOFError:
        print(f"Aucune saisie détectée, utilisation de la valeur par défaut : {defaut}")
        return defaut

    if saisie == "":
        return defaut

    try:
        nb = int(saisie)
    except ValueError:
        print(f"Entrée invalide, utilisation de la valeur par défaut : {defaut}")
        return defaut

    if nb < 2:
        print(f"Le nombre doit être >= 2, utilisation de la valeur par défaut : {defaut}")
        return defaut

    if nb > maximum:
        print(f"{nb} dépasse le nombre d'étapes disponibles ({maximum}), limitation à {maximum}")
        return maximum

    return nb


def demander_type_reseau(defaut=0):
    print("Topologie du réseau : 0=ligne, 1=boucle, 2=grille, 3=multi-boucles")
    try:
        saisie = input(f"Type de réseau (défaut={defaut}) : ").strip()
    except EOFError:
        print(f"Aucune saisie détectée, utilisation du type par défaut : {defaut}")
        return defaut

    if saisie == "":
        return defaut

    try:
        a = int(saisie)
    except ValueError:
        print(f"Entrée invalide, utilisation du type par défaut : {defaut}")
        return defaut

    if a not in [0, 1, 2, 3]:
        print(f"Type hors plage, utilisation du type par défaut : {defaut}")
        return defaut

    return a


def demander_topologie_multiboucles():
    try:
        saisie_nb = input("Nombre de boucles de neurones : ").strip()
    except EOFError:
        saisie_nb = ""

    try:
        nb_boucles = int(saisie_nb)
        if nb_boucles <= 0:
            raise ValueError
    except ValueError:
        nb_boucles = 2
        print("Entrée invalide, utilisation de 2 boucles par défaut")

    tailles = []
    for i in range(nb_boucles):
        try:
            s = input(f"Nombre de neurones dans la boucle {i+1} : ").strip()
        except EOFError:
            s = ""

        try:
            t = int(s)
            if t <= 0:
                raise ValueError
        except ValueError:
            t = 5
            print(f"Entrée invalide pour la boucle {i+1}, utilisation de 5")
        tailles.append(t)

    return tailles


def ajuster_n_pour_grille(n):
    cote = max(1, int(round(np.sqrt(n))))
    n_carre = cote * cote
    if n_carre != n:
        print(f"Topologie grille: n={n} ajusté automatiquement à {n_carre} ({cote}x{cote})")
    return n_carre


def demander_mode_rapide(defaut=True):
    rep_defaut = "o" if defaut else "n"
    try:
        saisie = input(f"Mode rapide (moins précis mais plus rapide) ? [o/n] (défaut={rep_defaut}) : ").strip().lower()
    except EOFError:
        print(f"Aucune saisie détectée, mode rapide={'activé' if defaut else 'désactivé'}")
        return defaut

    if saisie == "":
        return defaut
    if saisie in ["o", "oui", "y", "yes"]:
        return True
    if saisie in ["n", "non", "no"]:
        return False

    print(f"Entrée invalide, mode rapide={'activé' if defaut else 'désactivé'}")
    return defaut


def reduire_base_apprentissage(X_train, y_train, max_samples=1500, seed=42):
    if len(X_train) <= max_samples:
        return X_train, y_train

    rng = np.random.default_rng(seed)
    indices = rng.choice(len(X_train), size=max_samples, replace=False)
    return X_train[indices], y_train[indices]


def etiqueter_neurones(W, X_train, y_train):
    votes = [Counter() for _ in range(len(W))]
    for p, y in zip(X_train, y_train):
        g = compet(p, W, len(W))
        votes[g][int(y)] += 1

    label_par_neurone = {}
    for i, c in enumerate(votes):
        if len(c) > 0:
            label_par_neurone[i] = c.most_common(1)[0][0]
    return label_par_neurone, votes


def predire(W, label_par_neurone, X, label_defaut):
    y_pred = []
    for p in X:
        g = compet(p, W, len(W))
        y_pred.append(label_par_neurone.get(g, label_defaut))
    return np.array(y_pred, dtype=int)


def accuracy(y_true, y_pred):
    return float(np.mean(y_true == y_pred))


def matrice_confusion(y_true, y_pred, classes):
    index_classes = {c: i for i, c in enumerate(classes)}
    cm = np.zeros((len(classes), len(classes)), dtype=int)
    for yt, yp in zip(y_true, y_pred):
        cm[index_classes[int(yt)], index_classes[int(yp)]] += 1
    return cm


def afficher_matrice_confusion(cm, classes):
    fig, ax = pl.subplots(figsize=(6, 5))
    im = ax.imshow(cm, cmap='Blues')
    ax.set_title("Matrice de confusion (test)")
    ax.set_xlabel("Classe prédite")
    ax.set_ylabel("Classe réelle")
    ax.set_xticks(np.arange(len(classes)))
    ax.set_yticks(np.arange(len(classes)))
    ax.set_xticklabels(classes)
    ax.set_yticklabels(classes)

    for i in range(cm.shape[0]):
        for j in range(cm.shape[1]):
            ax.text(j, i, str(cm[i, j]), ha='center', va='center', color='black', fontsize=8)

    fig.colorbar(im, ax=ax)
    pl.tight_layout()
    pl.show()


def prototypes_par_classe(W, label_par_neurone, classes):
    prototypes = {}
    for c in classes:
        indices_neurones = [i for i, lbl in label_par_neurone.items() if lbl == c]
        if len(indices_neurones) == 0:
            continue
        proto = np.mean(W[indices_neurones], axis=0)
        prototypes[c] = np.clip(proto, 0.0, 1.0)
    return prototypes


def prototypes_purs_par_classe(W, votes, classes):
    prototypes_purs = {}
    info_purete = {}

    for c in classes:
        meilleur_idx = None
        meilleure_purete = -1.0
        meilleur_support = -1

        for i, compteur in enumerate(votes):
            if len(compteur) == 0:
                continue
            label_majoritaire, support = compteur.most_common(1)[0]
            if label_majoritaire != c:
                continue

            total = 0
            for v in compteur.values():
                total += int(v)
            purete = support / total

            if purete > meilleure_purete or (purete == meilleure_purete and support > meilleur_support):
                meilleure_purete = purete
                meilleur_support = support
                meilleur_idx = i

        if meilleur_idx is not None:
            prototypes_purs[c] = np.clip(W[meilleur_idx], 0.0, 1.0)
            info_purete[c] = (meilleur_idx, meilleure_purete, meilleur_support)

    return prototypes_purs, info_purete


def afficher_representants(prototypes, classes, cote):
    fig, axes = pl.subplots(2, 5, figsize=(10, 5))
    axes = axes.ravel()
    for i, c in enumerate(classes):
        ax = axes[i]
        if c in prototypes:
            ax.imshow(prototypes[c].reshape(cote, cote), cmap='gray')
            ax.set_title(f"Classe {c}")
        else:
            ax.text(0.5, 0.5, "N/A", ha='center', va='center')
            ax.set_title(f"Classe {c}")
        ax.axis('off')
    pl.suptitle("Prototype SOM de chaque classe")
    pl.tight_layout()
    pl.show()


def afficher_representants_comparaison(prototypes_moyens, prototypes_purs, classes, cote):
    fig, axes = pl.subplots(2, len(classes), figsize=(2 * len(classes), 5))
    if len(classes) == 1:
        axes = np.array([[axes[0]], [axes[1]]])

    for j, c in enumerate(classes):
        ax_moy = axes[0, j]
        ax_pur = axes[1, j]

        if c in prototypes_moyens:
            ax_moy.imshow(prototypes_moyens[c].reshape(cote, cote), cmap='gray')
        else:
            ax_moy.text(0.5, 0.5, "N/A", ha='center', va='center')
        ax_moy.set_title(f"Moyen C{c}")
        ax_moy.axis('off')

        if c in prototypes_purs:
            ax_pur.imshow(prototypes_purs[c].reshape(cote, cote), cmap='gray')
        else:
            ax_pur.text(0.5, 0.5, "N/A", ha='center', va='center')
        ax_pur.set_title(f"Pur C{c}")
        ax_pur.axis('off')

    pl.suptitle("Comparaison prototypes SOM (ligne 1: moyen, ligne 2: plus pur)")
    pl.tight_layout()
    pl.show()


def afficher_neurones_som(W, nb_a_afficher, cote):
    nb_total = len(W)
    nb = min(nb_a_afficher, nb_total)
    if nb <= 0:
        return

    cols = min(5, nb)
    rows = int(np.ceil(nb / cols))

    fig, axes = pl.subplots(rows, cols, figsize=(2.2 * cols, 2.2 * rows))
    axes = np.array(axes).reshape(-1)

    indices = np.linspace(0, nb_total - 1, nb, dtype=int)

    for i, idx in enumerate(indices):
        ax = axes[i]
        ax.imshow(np.clip(W[idx], 0.0, 1.0).reshape(cote, cote), cmap='gray')
        ax.set_title(f"N{idx}")
        ax.axis('off')

    for i in range(nb, len(axes)):
        axes[i].axis('off')

    pl.suptitle(f"Neurones SOM affichés ({nb}/{nb_total})")
    pl.tight_layout()
    pl.show()


def afficher_evolution_neurones(historique_W, nb_neurones, cote, nb_etapes):
    nb_snapshots = len(historique_W)
    if nb_snapshots == 0:
        return

    nb_lignes = min(nb_neurones, len(historique_W[-1]))
    indices_neurones = np.linspace(0, len(historique_W[-1]) - 1, nb_lignes, dtype=int)
    indices_etapes = np.linspace(0, nb_snapshots - 1, nb_etapes, dtype=int)

    fig, axes = pl.subplots(nb_lignes, nb_etapes, figsize=(1.8 * nb_etapes, 1.8 * nb_lignes))
    axes = np.array(axes, dtype=object)
    if nb_lignes == 1 and nb_etapes == 1:
        axes = np.array([[axes.item()]])
    elif nb_lignes == 1:
        axes = axes.reshape(1, -1)
    elif nb_etapes == 1:
        axes = axes.reshape(-1, 1)

    for i, idx_neurone in enumerate(indices_neurones):
        for j, idx_etape in enumerate(indices_etapes):
            ax = axes[i, j]
            img = np.clip(historique_W[idx_etape][idx_neurone], 0.0, 1.0).reshape(cote, cote)
            ax.imshow(img, cmap='gray')
            if i == 0:
                ax.set_title(f"t={idx_etape}")
            if j == 0:
                ax.set_ylabel(f"N{idx_neurone}")
            ax.set_xticks([])
            ax.set_yticks([])

    pl.suptitle("Évolution des neurones pendant l'apprentissage")
    pl.tight_layout()
    pl.show()



##############################################
#   Classification de chiffres (digits)      #
##############################################
tmps1=time.time()

repertoire = os.path.dirname(__file__)
fichier_images = os.path.join(repertoire, "digits_extrait_images.csv")
fichier_labels = os.path.join(repertoire, "digits_extrait_labels.csv")

X, y = charger_digits(fichier_images, fichier_labels)
X_train, X_test, y_train, y_test = split_train_test(X, y, ratio_test=0.2, seed=42)

melange = 1 #mélange si >=1
a = demander_type_reseau(defaut=2) # 0 ligne; 1 boucle; 2 grille; 3 multi-boucles
mode_rapide = demander_mode_rapide(defaut=True)
tailles_boucles = None
if a == 3:
    tailles_boucles = demander_topologie_multiboucles()
    n = int(np.sum(tailles_boucles))
    print(f"Topologie multi-boucles : {tailles_boucles} (n total = {n})")
else:
    if a == 2:
        n_defaut = 49 if mode_rapide else 100
        n = demander_nombre_neurones(defaut=n_defaut) #nombre de neurones pour grille
        n = ajuster_n_pour_grille(n)
    else:
        n_defaut = 36 if mode_rapide else 64
        n = demander_nombre_neurones(defaut=n_defaut) #nombre de neurones

nb_neurones_affiches = demander_nombre_affichage(maximum=n, defaut=7)

if mode_rapide:
    tmax = 60
    V0 = 6 #Taille du voisinage du neurone gagnant au départ
    Q = 0.01 #Facteur de qualité
    tau = 25 #durée de la phase d'organisation du réseau
    X_train, y_train = reduire_base_apprentissage(X_train, y_train, max_samples=1500, seed=42)
else:
    tmax = 120
    V0 = 8 #Taille du voisinage du neurone gagnant au départ
    Q = 0.005 #Facteur de qualité
    tau = 50 #durée de la phase d'organisation du réseau

nb_etapes_evolution = demander_nombre_etapes(maximum=tmax + 1, defaut=8)
cart = carte(n)
W = np.random.rand(n, X_train.shape[1])
t, ind, L_erreur, Photo_W, tv = Kohonen(W, n, X_train, tau, Q, V0, a, melange, cart, tmax=tmax, tailles_boucles=tailles_boucles)

label_majoritaire = Counter(y_train.tolist()).most_common(1)[0][0]
label_par_neurone, votes_neurones = etiqueter_neurones(W, X_train, y_train)

y_pred_train = predire(W, label_par_neurone, X_train, label_majoritaire)
y_pred_test = predire(W, label_par_neurone, X_test, label_majoritaire)

acc_train = accuracy(y_train, y_pred_train)
acc_test = accuracy(y_test, y_pred_test)

classes = sorted(np.unique(y).tolist())
cm = matrice_confusion(y_test, y_pred_test, classes)
prototypes = prototypes_par_classe(W, label_par_neurone, classes)
prototypes_purs, info_purete = prototypes_purs_par_classe(W, votes_neurones, classes)

print(f"Époques exécutées : {t}")
print(f"Convergence détectée : {ind}")
print(f"Neurones étiquetés : {len(label_par_neurone)}/{n}")
print(f"Accuracy train : {acc_train:.4f}")
print(f"Accuracy test  : {acc_test:.4f}")
print(f"Temps total    : {time.time() - tmps1:.2f} s")
print(f"Mode rapide    : {mode_rapide}")
print(f"Taille train   : {len(X_train)}")
print(f"Neurones affichés : {nb_neurones_affiches}")
print(f"Étapes d'évolution affichées : {nb_etapes_evolution}")
print(f"Prototypes créés : {len(prototypes)}/{len(classes)}")
print(f"Prototypes purs : {len(prototypes_purs)}/{len(classes)}")
for c in classes:
    if c in info_purete:
        idx, purete, support = info_purete[c]
        print(f"Classe {c} -> neurone pur #{idx} | pureté={purete:.3f} | support={support}")
print("Matrice de confusion (lignes=réel, colonnes=prédit):")
print(cm)

pl.figure(figsize=(8, 4))
pl.plot(L_erreur, color='red')
pl.title("Erreur moyenne par époque")
pl.xlabel("Époque")
pl.ylabel("Erreur")
pl.grid(True)
pl.tight_layout()
pl.show()

cote = int(np.sqrt(X.shape[1]))
historique_W = Photo_W + [np.copy(W)]
afficher_neurones_som(W, nb_neurones_affiches, cote)
afficher_evolution_neurones(historique_W, nb_neurones_affiches, cote, nb_etapes_evolution)
afficher_matrice_confusion(cm, classes)
afficher_representants(prototypes, classes, cote)
afficher_representants_comparaison(prototypes, prototypes_purs, classes, cote)

