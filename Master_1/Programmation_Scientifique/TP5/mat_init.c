#include <stdio.h>
#include "matrix.h"

void mat_init(Matrix *M)
{  
  for (int i = 0; i<M->nrow; i++)
  {
    for (int j = 0; j<M->ncol; j++)
    {
      printf("Rentrer la valeur M[%d][%d] = ",i,j);
      scanf("%lf",(M->mat)+i*(M->nrow)+j); // On enregistre la valeur tapé dans l'adresse de M.mat[i][j]
      }
  }
}
