#include <stdio.h>
#include "matrix.h"

Matrix matmul(Matrix *A,Matrix *x)
{
  int n = A->row;
  Matrix R = malloc(n*sizeof(*R.mat));
  R.nrow = n;
  for (int i = 0;i<n;i++)
  {
      for (int k = 0;k<n;k++)
      {
        R[k] = R.mat[k] + A->mat[i*n+k]*x->mat[k];
      }
  }
  x = &R;
}
