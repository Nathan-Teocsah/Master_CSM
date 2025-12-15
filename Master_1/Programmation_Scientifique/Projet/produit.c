#include <stdio.h>
#include <math.h>
#include "header.h"

void produit(Matrix *A, Matrix *X, Matrix_double *Res)
{
  int n = A->nrow;
  
  for (int i = 0;i<n;i++) 
    for (int j = 0;j<n;j++) 
      Res->p[i] += (double)A->mat[i][j] * (double)X->p[j];
}
