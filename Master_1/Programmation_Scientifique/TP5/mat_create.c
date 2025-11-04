#include <stdio.h>

void mat_create(Matrix M, int nrow, int ncol)
{
  M.nrow = nrow;
  M.ncol = ncol;
  M.mat = malloc(nrow*ncol*sizeof(double));
}
