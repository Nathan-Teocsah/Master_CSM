#include <stdio.h>
#include <lapacke.h>
#include <cblas.h>
#include <math.h>
#include "header.h"


int main()
{  
  printf("Cette algorithme résoud Ax=b pour A une matrice,\navec des 1/2 sur la diagonale et des -1 sur les sur et sous diagonale, \net regarde l'erreur informatique commise en fonction des paramètres.\n\n");
  
  printf("A = \n");
  for (int i=0; i<4;i++) // On affiche la matrice que l'on va manipuler en dimension 5
  {
    for (int j=0;j<4;j++)
    {
      if (i==j) printf("   %d  ",2);  
      else if ((j==(i+1))||(j==(i-1))) printf("  %d  ",-1);
      else printf("   %d  ",0);
    }
    printf("\n");
  }
  
  printf("\nb =\n");
  for (int i=0; i<4;i++) printf("    h^2\n");  
  
  printf("\n");
  printf("-----------------------------\n");
  printf("\n");
  
  //--------------------------------------------------------
  //-----------------ALGORITHME-----------------------------
  int n_min = 5;
  int n_pas = 10;
  int n_max = 150;


  //----------------Edition du début du fichier texte--------------
  FILE *fp = fopen("resultat.txt", "w");
  fprintf(fp,"n");
  for (int i = 0; i<(log(n_max)/log(10)+3); i++) fprintf(fp," "); //On introduit dans le fichier autant d'espace qu'il faut entre n_max et l'erreur relative associé
  fprintf(fp,"Erreur\n\n");
  
  
  //--------------Initialisation des matrices et vecteurs------------------  
  Matrix A, A_copie, b;
  Matrix_double X, Res; // X est le vecteur solution de AX=b et Res va être le résultat de calcul intermédiaire pour calculer l'erreur
  for (int n = n_min; n<=n_max; n += n_pas)
  {
    A.nrow = n;
    
    double h = 1/((double)(n+1));
    initiate_A_b(&A,&A_copie,&b,&X,h);
  
    
  //-------------------   RESOLUTION De AX=B  ----------------------
    int c = 1; //Nombre de colonne de b
    int *ipiv = (int *)calloc(n,sizeof(int));
    int INFO;
    sgesv_(&n, &c, A_copie.p,  &n, ipiv, X.p,  &n, &INFO);
    if (INFO!=0)
    {
      printf("\nEchec pour n = %d.\n",n);
    }

   //------------Calcul de l'erreur-----------------------
    
    produit(&A,&X,&Res);
    
    difference(&Res,&b);
    
    double erreur = norme1(&Res)/norme1(&b);
       
    
    //------------ On rentre la valeur de n et Norme dans le fichier texte--------------
    
    fprintf(fp,"%d",n);
    int espace = ((int)log10(n_max))-((int)log10(n))+4;
    for (int i = 0; i<espace; i++) fprintf(fp," "); //On introduit dans le fichier autant d'espace qu'il faut entre n_max et l'erreur relative associé
    fprintf(fp,"%e\n",erreur);
  }
  fclose(fp) ;
}


