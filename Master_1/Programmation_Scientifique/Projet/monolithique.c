#include <stdio.h>
#include <stdlib.h>
#include <lapacke.h>
#include <cblas.h>
#include <math.h>


int main()
{  
  printf("Cette algorithme résoud Ax=b pour A une matrice,\navec des 1/2 sur la diagonale et des -1 sur les sur et sous diagonale, \n et regarde l'erreur informatique commise en fonction des paramètres.\n\n");
  
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
  
  printf("b =\n");
  for (int i=0; i<4;i++) printf("    h^2\n");  
  
  printf("\n");
  printf("-----------------------------\n");
  printf("\n");
  
  //--------------------------------------------------------
  //-----------------ALGORITHME-----------------------------
  
  int n_min = 5;
  int n_pas = 50;
  int n_max = 705;


  //----------------Edition du début du fichier texte--------------
  FILE *fp = fopen("resultat_m.txt", "w");
  fprintf(fp,"n");
  for (int i = 0; i<(log(n_max)/log(10)+3); i++) fprintf(fp," "); //On introduit dans le fichier autant d'espace qu'il faut entre n_max et l'erreur relative associé
  fprintf(fp,"Norme\n\n");
  
  
  //--------------Calcul de l'erreur pour différentes valeur de n------------------
 
  
  
  for (int n = n_min; n<(n_max+1);n = n + n_pas )
  {
    float *p_b = (float*)malloc(n*sizeof(*p_b));
    double h = 1/((double)(n+1));
    float** pp_A = (float **)malloc(n*sizeof(*pp_A));
    float* p_A = (float *)calloc(n*n,sizeof(*p_A)); // Matrice A stockée sous-forme d'un vecteur ligne
    for (int i = 0; i<n;i++) pp_A[i] = p_A+i*n; // On définit pp_A* comme l'adresse de la ième ligne

    for (int i=0; i<n;i++) // On définit A comme dans l'énoncé
    {
      for (int j=0;j<n;j++)
      {
        if (i==j) *(p_A+i*n+i) = 2;
        else if ((j==(i+1))||(j==(i-1))) *(p_A+i*n+j) = -1;
      }
      p_b[i] = pow(h,2);
    }      
    
//-------------------   RESOLUTION De AX=B  ----------------------
    int c = 1; //Nombre de colonne de b
    int *ipiv = (int *)calloc(n,sizeof(int));
    int INFO;
    sgesv_(&n, &c, p_A,  &n, ipiv, p_b,  &n, &INFO);
    if (INFO!=0)
    {
      printf("\nEchec pour n = %d.\n",n);
    }
    
    // On redéfinit b et on définit le vecteur solution
    double *p_x = (double*)malloc(n*sizeof(*p_x));
    double *p_b1 = (double*)malloc(n*sizeof(*p_b1));
    for (int i = 0; i<n;i++)
    {
      p_x[i] = (double)p_b[i];
      p_b1[i] = pow(h,2);
    }

//------------Reinitialise A comme avant et non pas comme décomposition LU--------------   
  
    for (int i=0; i<n;i++) // On définit A comme dans l'énoncé
    {
      for (int j=0;j<n;j++)
      {
        if (i==j) pp_A[i][i] = 2;
        else if ((j==(i+1))||(j==(i-1))) pp_A[i][j] = -1;
        else pp_A[i][j] = 0;
      }
    } 

  //------------Calcul de l'erreur-----------------------
    
    double Norme = 0;  
    double S = 0;
    for (int i=0;i<n;i++)
    {
      S = 0;
      for (int k=0;k<n;k++)
      {
        S += pp_A[i][k]*p_x[k];
      }
      Norme += fabs(S-p_b1[i]);
    }
    
    Norme /= (n*pow(h,2));    
    
    
    //------------ On rentre la valeur de n et Norme dans le fichier texte--------------
    fprintf(fp,"%d",n);
    int espace = ((int)log10(n_max))-((int)log10(n))+4;
    for (int i = 0; i<espace; i++) fprintf(fp," "); //On introduit dans le fichier autant d'espace qu'il faut entre n_max et l'erreur relative associé
    fprintf(fp,"%e\n",Norme);
  }
  fclose(fp) ;
}


