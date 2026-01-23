#include <stdio.h>
#include <stdlib.h>
#include "header.h"

void Creer_maillage(double a, double b, double c, double d, int n1, int n2, int t, FILE *fp)
{
//====================== Cette ALGORITHME Créer un maillage sur un quadrangle ==============================
// Omega = [a;b] x [c; d] avec a < b  et c < d
// n1 = nombre de noeuds en abscisse
// n2 = nombre de noeuds en ordonnée
// t = type d'élément : t = 1 pour des quadrangles, t = 2 pour des triangles
// fp = fichier de sortie


  int n = n1 * n2; // n = est le nombre de noeuds
  fprintf(fp,"%d\n",n);
  
  double h1 = (b-a)/(n1-1); // 
  double h2 = (d-c)/(n2-1);
  
  double x,y;
  for (int i_y = 0; i_y < n2; i_y++) // Boucle sur les lignes (ordonnée)
  {
    for (int i_x = 0; i_x< n1; i_x++) // Boucle sur les colonnes (abscisse)
    {
      x = a + h1 * i_x;
      y = c + h2 * i_y;
      fprintf(fp,"%lf %lf\n",x,y);
    }
  }
  
  int m = (n1 - 1)*(n2 - 1); // Nombre d'éléments (triangle ou quadrangle)  
  int *p_nbtel = &m; //nbtel = nombre d'éléments ===================== REDONDANT, donné par m
  int p; // p = nombre de noeuds par élément
  int q; // q = nombre d'arêtes par élément ========================== REDONDANT, donné par p, car c'est une figure fermée
  //On initialise le tableau des arrêtes
  int *p_nbaret = &p; // nbaret = nombre d'arrête dans un élément ==== REDONDANT, donné par p
  int nrefdom = 0; // l'intérieur du domaine Omega est numéroté : 0
  int *p_nRefAr, **nRefAr;
  const int nrefcot[] = {1,2,3,4}; // numérotation des bords du domaine Omega
  
  switch (t) {
	  case 1 : // t = 1 : quadrangle
	    p = 4; // p = 4 (nombre de noeuds par éléments)
	    q = *p_nbaret;
            //On initialise le tableau contenant le numéro des arrêtes à 0
            p_nRefAr = malloc(*p_nbaret**p_nbtel*sizeof(*p_nRefAr));
            nRefAr = malloc(*p_nbtel*sizeof(*nRefAr));
            for (int i=0;i<*p_nbtel;i++) nRefAr[i] = p_nRefAr+i**p_nbaret;
            for (int i=0;i<*p_nbtel;i++) {
              for (int j=0;j<*p_nbaret;j++) {
                nRefAr[i][j] = nrefdom;
              }
            }
            
            etiqAr(t, n1, n2, nrefdom, nrefcot, *p_nbtel, *p_nbaret, nRefAr);
            
	    fprintf(fp,"%d %d %d %d\n",m, t, p, q);
	    for (int i = 0; i < (n1-1); i++) // boucle sur les colonnes
	    {
	      for (int j = 0; j< (n2-1); j++) // boucle sur les lignes
	      {
	        int e0 = 2 + n1 * i + j ; //On récupère le numéro global du 1er sommet de l'élément (i+1)*(j+1)
	        int numero_element = j + i*(n1-1); // Numéro de l'élément sur lequel on est
          // e0 : sommet en bas à droite ============ e0+ n1 : sommet en haut à droite
          //e0 + n1 -1 : sommet en haut à gauche ==== e0 - 1 : sommet en bas à gauche
	        fprintf(fp,"numero : %d || %d %d %d %d %d %d %d %d\n",numero_element, e0 + n1, e0 + n1 - 1, e0 - 1, nRefAr[numero_element][0], nRefAr[numero_element][1], nRefAr[numero_element][2], nRefAr[numero_element][3]);
	      }
	    }
	    break;
	    
	  case 2 : // t = 2: triangle
	    m = 2*m;
	    p = 3; // p = 3
      q = *p_nbaret;
	    
      //On initialise le tableau contenant le numéro des arrêtes à 0
      p_nRefAr = malloc(*p_nbaret**p_nbtel*sizeof(*p_nRefAr));
      nRefAr = malloc(*p_nbtel*sizeof(*nRefAr));
      for (int i=0;i<*p_nbtel;i++) nRefAr[i] = p_nRefAr+i**p_nbaret;
      for (int i=0;i<*p_nbtel;i++) {
        for (int j=0;j<*p_nbaret;j++) {
          nRefAr[i][j] = nrefdom;
        }
      }
      
      etiqAr(t, n1, n2, nrefdom, nrefcot, *p_nbtel, *p_nbaret, nRefAr);
            
	    fprintf(fp,"%d %d %d %d\n",m, t, p, q);
	    for (int i = 0; i < (n1-1); i++) // boucle sur les colonnes
	    {
	      for (int j = 0; j< (n2-1); j++) // boucle sur les lignes
	      {
	        int e0 = 2 + n1 * i + j ; //On récupère le numéro global du 1er sommet du triangle du bas
	        int numero_element = 2*(j + i*(n1-1)); // Numéro du triangle du bas
	        fprintf(fp,"%d %d %d %d %d %d\n", e0, e0 + n1 - 1, e0 - 1, nRefAr[numero_element][0], nRefAr[numero_element][1], nRefAr[numero_element][2]); // Triangle du bas
	        fprintf(fp,"%d %d %d %d %d %d\n", e0 + n1 - 1, e0, e0 + n1, nRefAr[numero_element+1][0], nRefAr[numero_element+1][1], nRefAr[numero_element+1][2]);// Triangle du haut
	      }
	    }
	    break;
  }
}
