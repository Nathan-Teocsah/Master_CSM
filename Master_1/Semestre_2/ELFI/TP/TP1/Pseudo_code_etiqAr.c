void etiqAr(int type1, int n1, int n2,...,int **nRefAr)
// ATTENTION : remplacer la numérotation des bords du domaines Omega (0,1,2,3,4) par (nrefdom,nrefcot[0],...)

//===================== CARRE : énumération des arrêtes =======================

int c = (n1-1)(n2-1)-(n1-2); // Numéro de l'élément en haut à gauche du maillage

//======On numérote les éléments du bord========
//Ligne du bas du maillage
for (int i = 0;i<n1-1;i++)
{
  nRefAr[i][3] = 1;
}

//Colonne de droite
for (int i = n1-2;i<(n1-1)*(n2-1);i += n1-1)
{
  nRefAr[i][3] = 2;
}

//Ligne du haut du maillage
for (int i=c-1;i<(n1-1)*(n2-1);i++)
{
  nRefAr[i][1] = 3;
}

//Colonne de gauche
for (int i=0;i<c;i+=n1-1)
{
  nRefAr[i][2] = 4;
}

//===================== TRIANGLE : énumération des arrêtes =======================
//======On numérote les éléments du bord========
//Ligne du bas du maillage (on saute un triangle sur 2)
for (int i = 0;i<2*(n1-1)-1;i+=2)
{
  nRefAr[i][2] = 1;
}

//Colonne de droite
for (int i = 2*(n1-1)-1;i<2*(n1-1)*(n2-1);i += 2*(n1-1))
{
  nRefAr[i][1] = 2;
}

//Ligne du haut du maillage
for (int i=2*c-1;i<2*(n1-1)*(n2-1);i+=2)
{
  nRefAr[i][2] = 3;
}

//Colonne de gauche
for (int i=0;i<2*c-1;i+=2*(n1-1))
{
  nRefAr[i][1] = 4;
}
