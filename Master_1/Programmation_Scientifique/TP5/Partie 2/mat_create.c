#include <stdio.h>
#include <stdlib.h>
#include "matrix.h"

void mat_create(Matrix *M, int n, int m)
{
  M->nrow = n;
  M->ncol = m;
  M->mat = (double**) malloc(n*m*sizeof(double));
  if (M->mat == NULL)
  {
    printf("L'allocation a échoué");
  }
  else
  {
    M->mat_alloc = (double*) malloc(n*sizeof(double *));
    for (int i = 0; i<n; i++) M->mat_alloc[i] = M.mat[i*m]; // on défini mat_alloc[i] comme l'adresse de la i-ieme ligne de M->mat[i]
  }
}
