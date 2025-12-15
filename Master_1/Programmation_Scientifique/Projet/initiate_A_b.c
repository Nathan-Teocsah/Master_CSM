#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "header.h"

void initiate_A_b(Matrix *A,  Matrix *A_copie,  Matrix *b,  Matrix_double* X, Matrix_double* Res,  double h)
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
  
  A->mat = (float **)malloc(n*sizeof(*A->mat));
  A->p = (float *)malloc(n*n*sizeof(*A->p));
  
  A_copie->mat = (float **)malloc(n*sizeof(*A_copie->mat));
  A_copie->p = (float *)malloc(n*n*sizeof(*A_copie->p));
  
  b->mat = (float **)malloc(n*sizeof(*b->mat));
  b->p = (float*)malloc(n*sizeof(*b->p));
  
  X->mat = (double **)malloc(n*sizeof(*X->mat));
  X->p = (double*)malloc(n*sizeof(*X->p));
  
  Res->mat = (double **)malloc(n*sizeof(*X->mat));
  Res->p = (double*)malloc(n*sizeof(*X->p));
  
  
  for (int i = 0; i<n;i++) 
  {
    A->mat[i] = A->p+i* A->ncol; 
    A_copie->mat[i] = A_copie->p + i* A_copie->ncol; 
    b->mat[i] = b->p + i* b->ncol;
    X->mat[i] = X->p + i*X->ncol;
    Res->mat[i] = Res->p + i* Res->ncol;
  }

  
  for (int i=0; i<n;i++) // On définit A comme dans l'énoncé
  {
    for (int j=0;j<n;j++)
    {
      if (i==j) *((A->p)+i*n+i) = 2;
      else if ((j==(i+1))||(j==(i-1))) *((A->p)+i*n+j) = -1;
      A_copie->mat[i][j] = A->mat[i][j];
    }
    X->p[i] = pow(h,2);
    b->p[i] = (float) X->p[i];
  } 
}
