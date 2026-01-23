void etiqAr(int type1, int n1, int n2,int nrefdom, const int *nrefcot, int nbtel, int nbaret, int **nRefAr)
{
/*
n1 : nombre de sommets sur une ligne
n2 : nombre de sommets sur une colonne

type1 = 1 si les éléments du maillage sont des triangles et 2 si Carrés
nrefdom = intérieur du domaine
nrefcot = numéro des bords du maillage

nRefAr = tableau de nbtel*nbaret lignes et 3 ou 4 colonnes (suivant si c'est un triangle ou un carré)

VARIABLES REDONDANTES !! 
nbtel = nombre d'éléments dans le maillage (dépend uniquement du type et de n1 et n2)
nbaret = nombre d’arête dans un élément (dépend uniquement du type)
*/

int c = (n1-1)*(n2-1)-(n1-2); // Numéro de l'élément en haut à gauche du maillage

switch (type1) {
  //===================== CARRE : énumération des arrêtes =======================

    case 1 :
      //======On numérote les éléments du bord========
      //Ligne du bas du maillage
      for (int i = 0;i<n1-1;i++)
      {
        nRefAr[i][3] = nrefcot[0];
      }

      //Colonne de droite
      for (int i = n1-2;i<(n1-1)*(n2-1);i += n1-1)
      {
        nRefAr[i][0] = nrefcot[1];
      }

      //Ligne du haut du maillage
      for (int i=c-1;i<(n1-1)*(n2-1);i++)
      {
        nRefAr[i][1] = nrefcot[2];
      }

      //Colonne de gauche
      for (int i=0;i<c;i+=n1-1)
      {
        nRefAr[i][2] = nrefcot[3];
      }
      break;
      
    case 2 :
      //===================== TRIANGLE : énumération des arrêtes =======================
      //======On numérote les éléments du bord========
      //Ligne du bas du maillage (on saute un triangle sur 2)
      for (int i = 0;i<2*(n1-1)-1;i+=2)
      {
        nRefAr[i][2] = nrefcot[0];
      }

      //Colonne de droite
      for (int i = 2*(n1-1)-1;i<2*(n1-1)*(n2-1);i += 2*(n1-1))
      {
        nRefAr[i][1] = nrefcot[1];
      }

      //Ligne du haut du maillage
      for (int i=2*c-1;i<2*(n1-1)*(n2-1);i+=2)
      {
        nRefAr[i][2] = nrefcot[2];
      }

      //Colonne de gauche
      for (int i=0;i<2*c-1;i+=2*(n1-1))
      {
        nRefAr[i][1] = nrefcot[3];
      }
      break;
  }
}
