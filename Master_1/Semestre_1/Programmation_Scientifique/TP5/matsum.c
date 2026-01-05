#include <stdio.h>
#include "matrix.h"

void matsum(Aatrix A, Aatrix B, Matrix *Res) 
{
  for (int i = 0; i<A.nrow; i++)
  {
    for (int j = 0; j<A.ncol; j++)
    {
      Res->mat[i*(Res->nrow)+j] = A.mat[i*A.ncol+j]+B.mat[i*B.ncol+j];
    }
  }
}
