#include <stdio.h>
#include "header.h"

void mat_print(Matrix M)
{
  printf("%f \n",M.mat[0]);
  for (int i = 1; i<M.nrow; i++)
  {
    printf("    %f \n",M.mat[i]);
  }
}
    
