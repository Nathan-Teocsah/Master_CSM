Pour ces deux exercices, on mettra en œuvre une méthode de validation croisée pour évaluer au mieux le taux d'erreur: séparer aléatoirement apprentissage et test, calculer le nombre de mal classés, recommencer, etc.

Le plus simple sera de faire une fonction qui prend en entrée X, y, (variable explicatives et numéro de classe) , la taille de l'ensemble test (aléatoire), et le nombre d'itérations, et renvoie la matrice de confusion cumulée.

# Maladie cardiaque

On dispose de la base de données du fichier HeartData.txt collectant des facteurs qui sont susceptibles d'influencer la maladie cardiaque. Ces données concernent des hommes du Western Cape, Afrique du Sud (voir https://web.stanford.edu/~hastie/ElemStatLearn//datasets/SAheart.info.txt).

Les variables renseignées sont

    numéro de patient (ici inutile)
    stp : pression sanguine systolique
     tobacco : quantité de tabac cumulée consommée (kg)
    ldl : taux de cholestérol (low density lipoprotein cholesterol)
    adiposity : adiposité
    famhist : antécédents familiaux (0=non, 1=oui)
    typea : comportement de type-A
    obesity : obésité
    alcohol : consommation courante d'alcool
    age 
    chd : coronary heart disease (1=oui, 0=non).

On cherche à prédire la variable chd à partir des autres. 

(a) Utiliser l'analyse discriminante pour prédire cette variable. Vous penserez à utiliser la validation croisée pour évaluer le modèle obtenu. Le MSE est ici simplement un taux d'erreur.

(b) Vous pourrez comparer différents modèles (basés sur différents sous ensembles de variables), en utilisant la validation croisée. 

Le fichier HeartData.py vous aidera à lire le fichier de données sous Python et à mener une analyse descriptive rapide. On trouvera aussi dans ce fichier le nom des modules permettant de réaliser l'analyse discriminante linéaire et l'analyse discriminante quadratique. 

# Digits

Appliquer l'analyse discriminante pour prédire la classe des images. Comparez les résultats à ceux qu'on obtient avec le clustering.

Les facteurs principaux sont en colonne de lda.fit_transform(X, y). On tracera les individus dans le plan des deux premiers facteurs.
On pourra essayer une analyse discriminante basée sur les premières composantes principales.