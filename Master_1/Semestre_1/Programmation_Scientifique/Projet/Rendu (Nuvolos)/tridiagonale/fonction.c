// Nathan HASCOET
//N etudiant : 20101512

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "header.h"

void initiate_A_b(Matrix_double  *A,  Matrix  *D, Matrix  *DL, Matrix  *DU,  Matrix *X, Matrix_double  *b, Matrix_double *Res, double h)
{
  // Initialisation des matrices et vecteurs nécessaire
  // a l'algorithme.
  // A, X, b : AX = b où A est tridiagonale
  // D : diagonale de A = 2 ... 2
  // DL : sous-diagonale de A = -1 ... -1
  // DU : sur-diagonale de A = -1 ... -1
  // Res : résultat des calculs intermédiaires
  
  int n = A->nrow;
  D->nrow = n;  
  DL->nrow = n-1; 
  DU->nrow = n-1; 
  b->nrow = n;
  X->nrow = n;
  Res->nrow = n;
  
  A->ncol = n;
  D->ncol = 1;
  DL->ncol = 1;
  DU->ncol = 1;
  b->ncol = 1;
  X->ncol = 1;
  Res->ncol = 1;

  //Initialisation de chaque matrice dynamiquement
  Matrix_double* S_d[3] = {A, b, Res};
  int lign,col;
  for (int i=0; i < 3; i++){
    lign = S_d[i]->nrow;
    col = S_d[i]->ncol;
    S_d[i]->mat = malloc(lign*sizeof(*S_d[i]->mat));
    S_d[i]->p = calloc(lign*col,sizeof(*S_d[i]->p));
    for (int j = 0; j<col;j++) 
    {
      S_d[i]->mat[j] = S_d[i]->p + j*col; 
    }
  }
  
  Matrix* S_s[4] = {D, DL, DU, X};
  for (int i=0; i < 4; i++){
    lign = S_s[i]->nrow;
    col = S_s[i]->ncol;
    S_s[i]->mat = malloc(lign*sizeof(*S_s[i]->mat));
    S_s[i]->p = calloc(lign*col,sizeof(*S_s[i]->p));
    for (int j = 0; j<col;j++) 
    {
      S_s[i]->mat[j] = S_s[i]->p + j*col; 
    }
  }
  
  // Initialisation des valeurs
  for (int i=0; i<n;i++) // On définit A comme dans l'énoncé
  {
    for (int j=0;j<n;j++)
    {
      if (i==j) 
      {
        A->mat[i][i] = 2;
        D->p[i] = A->mat[i][i];
      }
      else if (j==(i+1))
      {
        A->mat[i][j] = -1;
        DU->p[i] = A->mat[i][j];
      }
      else if (j==(i-1))
      {
        A->mat[i][j] = -1;
        DL->p[j] = A->mat[i][j];
      }
    }
    b->p[i] = pow(h,2);
    X->p[i] = b->p[i];
  } 
}




void produit(Matrix_double A, Matrix X, Matrix_double  *Res)
{
  int n = A.nrow;
  
  for (int i = 0;i<n;i++) 
  {
    for (int j = 0;j<n;j++) 
    {
      Res->p[i] += A.mat[i][j] * (double)X.p[j];
    }
  }
}



void difference(Matrix_double * v2,Matrix_double  v1) 
//Calcul v2-v1 que l'on stocke dans v2;
{  
  for (int i = 0; i<v1.nrow; i++) v2->p[i] = v2->p[i]- v1.p[i];
}



double norme1(Matrix_double  v)
{
  double N = 0;
  for (int i = 0; i<v.nrow; i++) N += fabs(v.p[i]);
  return N;
}




