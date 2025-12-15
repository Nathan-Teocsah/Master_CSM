#include <stdio.h>
#include <math.h>
#include "header.h"

void difference(Matrix_double* B,Matrix* A) //Calcul B-A que l'on stocke dans B;
{
  int n = A->nrow;
  
  for (int i = 0;i<n;i++) 
    B->p[i] = B->p[i]-A->p[i];
