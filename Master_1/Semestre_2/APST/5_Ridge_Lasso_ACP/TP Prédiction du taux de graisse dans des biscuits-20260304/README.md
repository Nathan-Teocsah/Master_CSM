Le programme PopUsRidgeLasso.py illustre l'effet du surajustement sur les données de population des Etats-Unis de 1900 à 2010, échantillonnés tous les 10 ans. L'ajustement par régression linéaire (moindres carrés) d'un polynôme d'ordre trop élevé sur ces données (x=année, y=population) conduit à des prédictions futures extravagantes. Le ridge et le lasso peuvent corriger cela.
Le programme trace les polynômes estimés pour divers degrés, et les polynômes estimés en ridge et lasso pour diverses valeurs de la pondération alpha (le lambda du cours). Il va falloir choisir cette pondération

    Estimation de la meilleure pondération ridge  par validation croisée. Pour ne pas prendre une plage de valeurs de alpha proposés trop grande (car le calcul en validation croisée est un peu lourd) le tracé du RMSE et de la norme de beta en fonction de alpha est proposé. Réajuster cette plage avant de faire tourner la validation croisée (avec un nombre de tirages suffisants).
    Noter que le tracé des polynômes estimés donne une idée de valeurs de alpha raisonnables, mais ceci n'est exploitable que dans le cas d'une régression polynomiale.
    Faire le calcul du RMSE pour chaque alpha avec le leave-one-out.
    Faire de même pour le lasso
    Conclure

La spectrométrie consiste à projeter de la lumière à différentes fréquences sur la matière à étudier. L'énergie aux différentes fréquences est plus ou moins absorbée par la matière selon sa composition moléculaire. On dispose ici de données spectrales dans 700 bandes de fréquence proche de l'infrarouge pour 32 biscuits ainsi que du taux de graisse dans ces biscuits.
Les 700 variables explicatives sont donc l'absorbance aux 700 bandes de fréquences. La variable à expliquer est le taux de graisse. Ces variables sont stockées dans le fichier Biscuit.csv, et lues par BiscuitSpectro.py.

En utilisant la régression Ridge et la régression Lasso, proposer un modèle permettant de prédire le taux de graisse à partir du spectre.
