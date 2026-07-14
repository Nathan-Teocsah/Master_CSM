# Objectif : fil rouge
Montrer que le schéma numérique proposé converge

# Déroulement
0. Début de l'oral :
__présentation de mon sujet de stage__ : consistance de gradients discrets sur des maillages non structurés 2D.

1. Présentation du plan :
__introduction__ : présente le contexte et motive l'étude du gradients discrets que l'on introduit à la section 3
__prérequis__ : présente les notations nécessaire à la définition du schéma numérique du gradient discrets étudiés
__Gradients discrets locaux__ : présente le gradients discrets
__Majoration de l'erreur__ : justifie la définition du pas _h_ proposée et justifie dans un cas particulier que le gradient converge
__Tests numériques__ : éprouve numériquement les résultat qui ont étés obtenus et tester la convergence pour des cas qui ne respectent pas les conditions énoncés.

2. Introduction : 
__Maillages non-structuré ?__ : modéliser des formes tels que des ailes d'avion, des voitures imposent d'utiliser des maillages non structurés.
__Difficultés__ : 
- définition du gradients discrets : utile pour obtenir une meilleure approximation de solutions dans le cadre des méthodes aux volume finis (pourquoi plus précis ? car en faisant un DL de la solutions, plus on prend des terme d'ordre élevés plus la solution sera précise)
- Définition du pas d'espace : dans le cas des maillages cartésiens carré, c'est la longueur du côté d'une cellule, ce pas est bien est bien car il permet de capter toute la géométrie de ce type de maillage. Si le maillage est non structuré, il n'est pas forcément possible d'avoir un pas qui permettent de capter toute la géométrie du maillage. Il faut l'adapter au schéma que l'on étudie. Ceci était l'objectif du stage, trouver un pas d'espace, de sorte qu'il puisse quantifier l'erreur du gradients discrets.

3. Prérequis

4. Gradients discrets locaux : 
__Hypothèse__ : On va chercher à approximer le gradient d'une fonction u donné d'ordre au moins C2. Cette fonction fournis une liste de valeurs ui pour chaque cellules qui la valeur moyenne de u sur cette cellule.
__Définition__ : On définit le gradients discrets de u sur chaque cellules de la manière suivante [montrer le tableau]. On remarque que ce gradient discret est local [si question dessus : le calcul du gradient pour une cellule donné ne dépend que des informations sur les voisins directs de cette cellules.].
__Discussion de Mi__ : La matrice M_i peut-être vu comme une perturbation de la matrice identité, on peut s'attendre, lorsque le terme x_ij_bar-x_ij est petit ou nulle, à ce que cette matrice soit proche de la matrice identité.

5. Majoration de l'erreur :
__Modélisation de u__ : u et grad(u) est constant sur chaque cellule égale à leur moyenne sur la cellule.
__Erreur de consistance__ : approximation entre le gradient de u et son approximation discrète. On commence par étudier cette erreur multiplié par M_i car cela permet d'évaluer plus facilement l'erreur. Cette erreur est noté Ri, elle est décomposé en 3 erreurs, obtenus à l'aide de DTI.
__Majoration M_iRi__ : On donne les majorations de ces différentes erreurs. Avec la définition du pas h proposé, l'erreur R2 tends vers l'infini pour un certain type de maillage. Il faut donc réviser la définition du maillage. Ce nouveau pas h permet de majorer Ri. Mais aussi presque entièrement l'erreur de consistance. Il reste cependant à contrôler M_i^-1. En général ce n'est pas possible sauf dans certains cas.
__Prérequis jusqu'au maillage triangulaire__ : juste expliquer les hypothèses.

__Présentation maillages__ : les maillages sont générés en choisissant le nombre de points sur le bords du domaines, ce qui conduit à certaines difficultés par la suite.
__Présentation des fonctions tests__ : on voit que les conditions de bords sont respectées, en effet dans les 2 cas, les valeurs de la fonction au bord sont le zéros machines. La fonction plateau beaucoup plus raide que la gaussienne, cette raideur est localisé sur le bord du cercle.
__Résultats numériques__ :
- Pour les besoins du stage mon tuteur m'a fournis un code C permettant de générer certains maillages et de faire la résolution sur ces maillages.
- J'ai apporté au code quelques modifications : codage du pas h défini un peu plus tôt dans l'exposé et coder une sous routine pour vérifier la conditions de convexité.
Les graphiques pour les courbes de convergence sont en échelle logarithmique avec sur l'axe des abscisses le pas des maillages et sur l'axe des ordonnées la valeur des erreurs correspondantes.
__Explications résultats__ :
- Il peut être observé la convergence pour les maillage cartésiens, et ce de manière assez rapide, en effet, l'ordre de convergence mesuré est comme on le verra après de 2.
- Pour le maillage de Delaunay : la convergence est elle aussi observée, cependant l'ordre est moins mais est celui qui avait été prédis par la théorie : ordre 1. 
- Pour les maillages déformé de déformation 0.5, l'ordre est toujours 1, et la convergence apparaît assez aisément, comme pour les maillages cartésiens. On peut remarquer que la courbe de convergence de déforme plus que pour la déformation 0.
- Pour une déformation 0.9, la courbe lié à la norme Cinfini est inutilisable pour récupérer un ordre de convergence. cependant celle associée à la norme L1 reste utilisable.
- Ordre de convergence : comme je le disais, l'ordre de convergence reste 1 pour la norme L1.

- Pour la fonction plateau : les

6. Conclusion :



