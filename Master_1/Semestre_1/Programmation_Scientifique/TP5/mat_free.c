#include <stdio.h>
#include "matrix.h"

void mat_free(Matrix M)
{
  free(M.mat);
}
