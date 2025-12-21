#include <stdio.h>
#include <math.h>
#include "header.h"

double norme1(Matrix_double v)
{
  double N = 0;
  for (int i = 0; i<v.nrow; i++) N += fabs(v.p[i]);
  return N;
}
