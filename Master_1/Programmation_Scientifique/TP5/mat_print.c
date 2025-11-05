#include <stdio.h>
#include "matrix.h"

void mat_print(Matrix M)
{
  for (int i = 0; i<M.nrow; i++)
  {
    printf("|");
    for (int j = 0;j<M.ncol; j++)
    {
      printf("%f ",*(M.mat+i*M.nrow+j));
    }
    printf("|");
    printf("\n");
  }
}
