#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "header.h"

void initiate_A_b(Matrix *A,  Matrix *A_copie,  Matrix* X,Matrix_double *b, Matrix_double* Res,  double h)
{
  int n = A->nrow;
  A_copie->nrow = n;  
  b->nrow = n;
  X->nrow = n;
  Res->nrow = n;
  
  A->ncol = n;
  A_copie->ncol = n;
  b->ncol = 1;
  X->ncol = 1;
  Res->ncol = 1;
  
  A->mat = malloc(n*sizeof(*A->mat));
  A->p = calloc(n*n,sizeof(*A->p));
  
  A_copie->mat = malloc(n*sizeof(*A_copie->mat));
  A_copie->p = malloc(n*n*sizeof(*A_copie->p));
  
  b->mat = malloc(n*sizeof(*b->mat));
  b->p = malloc(n*sizeof(*b->p));
  
  X->mat = malloc(n*sizeof(*X->mat));
  X->p = malloc(n*sizeof(*X->p));
  
  Res->mat = malloc(n*sizeof(*X->mat));
  Res->p = calloc(n,sizeof(*X->p));
  
  
  for (int i = 0; i<n;i++) 
  {
    A->mat[i] = A->p + i* A->ncol; 
    A_copie->mat[i] = A_copie->p + i* A_copie->ncol; 
    b->mat[i] = b->p + i* b->ncol;
    X->mat[i] = X->p + i*X->ncol;
    Res->mat[i] = Res->p + i* Res->ncol;
  }

  
  for (int i=0; i<n;i++) // On définit A comme dans l'énoncé
  {
    for (int j=0;j<n;j++)
    {
      if (i==j) A->mat[i][i] = 2;
      else if ((j==(i+1))||(j==(i-1))) A->mat[i][j] = -1;
      A_copie->mat[i][j] = A->mat[i][j];
    }
    b->p[i] = pow(h,2);
    X->p[i] = (float) b->p[i];
  } 
}




void produit(Matrix A, Matrix X, Matrix_double *Res)
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



void difference(Matrix_double* v2,Matrix_double v1) 
//Calcul v2-v1 que l'on stocke dans v2;
{  
  for (int i = 0; i<v1.nrow; i++) v2->p[i] = v2->p[i]- v1.p[i];
}



double norme1(Matrix_double v)
{
  double N = 0;
  for (int i = 0; i<v.nrow; i++) N += fabs(v.p[i]);
  return N;
}




