# Modèle de Cobb-Douglas : production, travail et capital

On considère les variables, chacune concernant la totalité des États-Unis (i étant l'indice d'une année) :

    P : production
    K : capital (valeur des usines, etc.)
    T : travail fourni (basé sur un calcul du nombre total de travailleurs)

On cherche à expliquer P à l'aide des variables (K,T). Le modèle de Cobb et Douglas est

P =α1Kα2Tα3

ce qui suggère le modèle statistique

log(Pi) = log(α1)+α2log(Ki)+α3log(Ti)+ui, E(ui) = 0, Var(ui) = σ2

Les régresseurs sont donc ici xi = (1,log(Ki),log(Ti)), la réponse est yi = log(Pi) et les paramètres du modèle β = (log(α1),α2,α3). Le logarithme et les changements de variables ont permis de rendre le modèle linéaire (par rapport à β).

Cobb et Douglas disposaient des données sur n = 24 années et trouvent des paramètres α2  et α3 proches de 1/4 et 3/4.

On fera la régression avec scikitlearn et manuellement, c'est engagé dans le fichier CobbDouglas.py


# Prédiction du maximum journalier de la teneur en Ozone dans l'air

## Le programme Ozone.py joint fournit la méthode de lecture des données d'ozone, ozone.txt,  avec la construction manuelle des dummy variables.

Proposer un modèle linéaire pour prédire le maximum journalier de la teneur en Ozone dans l'air maxO3 en fonction des variables météorologiques observées la veille (température, nébulosité, intensité du vent ouest-est à 9h, 12h et 15h, direction du vent, pluie oui/non) , et de la teneur en ozone de la veille (fichier Ozone.py. La valeur de la veille est déjà dans les variables, il n'y a pas lieu de l'incorporer). Estimer les paramètres puis interpréter le modèle obtenu (comment est-ce que maxO3 varie en fonction des autres variables?).

## Mettre en œuvre une validation croisée pour proposer un calcul du MSE.

Vous pourrez aussi utiliser cette méthode pour comparer plusieurs modèles (p.ex. inclure ou non vent et pluie) en comparant les MSE obtenus.. 

 # Pour approfondir: Méthode descendante.
On trouvera dans le fichier OzoneAoV.py une façon de procéder pour appliquer la méthode descendante en présence de données catégorielles, en utilisant les fonctions python d'analyse de variance.  