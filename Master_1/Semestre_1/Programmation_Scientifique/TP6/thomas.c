#include <stdio.h>
#include "header.h"

void thomas(Matrix *A,Matrix *b) // A est une matrice n*3 et b un vecteur de n ligne
{
  int n = A->nrow;
  
  
  for (int i = 1; i<n;i++)
  {
    float q = A->mat[i*3] / A->mat[(i-1)*3+1];
    A->mat[i*3+1] = A->mat[i*3+1]-q*A->mat[(i-1)*3+2];
    b->mat[i] = b->mat[i]-q*b->mat[i-1];
    A->mat[3*i]=0;
  }
}



