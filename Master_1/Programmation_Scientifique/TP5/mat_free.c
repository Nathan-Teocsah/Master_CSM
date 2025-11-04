#include <stdio.h>

void mat_free(Matrix M)
{
  free(M.mat);
}
