#include <stdio.h>
#include <stdlib.h>
#include "header.h"

void matmul(Matrix *A,Matrix *x)
{
  int n = A->nrow;
  Matrix R ;
  R.mat = malloc(n*sizeof(*R.mat));
  R.nrow = n;
  printf("\n");
  for (int i = 0;i<n;i++)
  {
      R.mat[i] = 0;
      for (int k = 0;k<n;k++)
      {
        R.mat[i] = R.mat[i] + A->mat[i*n+k]*x->mat[k];
      }
  }
  for (int i=0;i<n;i++)
  {
    x->mat[i] = R.mat[i];
  }
  
}
