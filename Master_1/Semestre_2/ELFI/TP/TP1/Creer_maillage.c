#include <stdio.h>
#include <stdlib.h>
#include "header.h"

void Creer_maillage(double a, double b, double c, double d, int n1, int n2, int t, FILE *fp)
{
//====================== Cette ALGORITHME Créer un maillage sur un quadrangle ==============================
// Omega = [a;b] x [c; d] avec a < b  et c < d


  int n = n1 * n2; // n = est le nombre de noeuds
  fprintf(fp,"%d\n",n);
  
  double h1 = (b-a)/(n1-1); // 
  double h2 = (d-c)/(n2-1);
  
  double x,y;
  for (int i_y = 0; i_y < n1; i_y++) // Boucle sur les lignes (ordonnée)
  {
    for (int i_x = 0; i_x< n2; i_x++) // Boucle sur les colonnes (abscisse)
    {
      x = a + h1 * i_x;
      y = b + h2 * i_y;
      fprintf(fp,"(%lf,%lf)\n",x,y);
    }
  }
  
  int m = (n1 - 1)*(n2 - 1); // Nombre d'éléments (triangle ou quadrangle)  
  int nbtel = m; //nbtel = nombre d'éléments
  int p; 
  //On initialise le tableau des arrêtes
  int *p_nbaret = &p; // nbaret = nombre d'arrête dans un élément
  int nrefdom = 0; // l'intérieur du domaine Omega est numéroté : 0
  int *p_nRefAr, **nRefAr;
  const int nrefcot[] = {1,2,3,4}; // numérotation des bords du domaine Omega
  
  switch (t) {
	  case 1 : // t = 1 : quadrangle
	    p = 4; // p = 4 (nombre de noeuds par éléments)
	    
            //On initialise le tableau contenant le numéro des arrêtes à 0
            p_nRefAr = calloc(*p_nbaret*nbtel,sizeof(*p_nRefAr));
            nRefAr = malloc(nbtel*sizeof(*nRefAr));
            for (int i=0;i<nbtel;i++) nRefAr[i] = p_nRefAr+i**p_nbaret;
            
            etiqAr(t, n1, n2, nrefdom, nrefcot, nbtel, *p_nbaret, nRefAr);
            
	    fprintf(fp,"%d %d %d\n",m, t, p );
	    for (int i = 0; i < (n1-1); i++) // boucle sur les lignes
	    {
	      for (int j = 0; j< (n2-1); j++) // boucle sur les colonnes
	      {
	        int e0 = 2 + n1 * i + j ; //On récupère le numéro global du 1er sommet de l'élément (i+1)*(j+1)
	        int numero_element = i + j*(n1-1); // Numéro de l'élément sur lequel on est
	        fprintf(fp,"%d %d %d %d %d %d %d %d\n",e0, e0 + n1, e0 + n1 - 1, e0 - 1, nRefAr[numero_element][0], nRefAr[numero_element][1], nRefAr[numero_element][2], nRefAr[numero_element][3]);
	      }
	    }
	    break;
	    
	  case 2 : // t = 2: triangle
	    m = 2*m;
	    p = 3; // p = 3
	    
            //On initialise le tableau contenant le numéro des arrêtes à 0
            p_nRefAr = calloc(*p_nbaret*nbtel,sizeof(*p_nRefAr));
            nRefAr = malloc(nbtel*sizeof(*nRefAr));
            for (int i=0;i<nbtel;i++) nRefAr[i] = p_nRefAr+i**p_nbaret;
            
            etiqAr(t, n1, n2, nrefdom, nrefcot, nbtel, *p_nbaret, nRefAr);
            
	    fprintf(fp,"%d %d %d\n",m, t, p );
	    for (int i = 0; i < (n1-1); i ++) // boucle sur les lignes
	    {
	      for (int j = 0; j< (n2-1); j++) // boucle sur les colonnes
	      {
	        int e0 = 2 + n1 * i + j ; //On récupère le numéro global du 1er sommet du triangle du bas
	        int numero_element = 2*i + j*(n1-1); // Numéro du triangle du bas
	        fprintf(fp,"%d %d %d %d %d %d\n",e0, e0 + n1, e0 - 1, nRefAr[numero_element][0], nRefAr[numero_element][1], nRefAr[numero_element][2]); // Triangle du bas
	        fprintf(fp,"%d %d %d %d %d %d\n",e0 + n1 - 1, e0, e0 + n1, nRefAr[numero_element+1][0], nRefAr[numero_element+1][1], nRefAr[numero_element+1][2]);// Triangle du haut
	      }
	    }
	    break;
  }
}
