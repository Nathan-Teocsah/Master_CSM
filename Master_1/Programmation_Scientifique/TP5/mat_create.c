#include <stdio.h>
#include <stdlib.h>
#include "matrix.h"

void mat_create(Matrix *M, int n, int m)
{
  M->nrow = n;
  M->ncol = m;
  M->mat = (double*) malloc(n*m*sizeof(double));
  if (M->mat == NULL)
  {
    printf("L'allocation a échoué");
  }
}
