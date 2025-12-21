#include <stdio.h>
#include <math.h>
#include "header.h"

void difference(Matrix_double* v2,Matrix_double v1) 
//Calcul v2-v1 que l'on stocke dans v2;
{  
  for (int i = 0; i<v1.nrow; i++) v2->p[i] = v2->p[i]- v1.p[i];
}
