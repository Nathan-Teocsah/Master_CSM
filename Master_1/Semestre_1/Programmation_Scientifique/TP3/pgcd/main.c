#include <stdio.h>
#include "dec1.h"

void main()
{
  

  printf("Algorithme pour calculer le pgcd de a et b.\n");
  printf("Entrer la valeur de a : "), scanf("%d", &a), printf("Entrer la valeur de b : "), scanf("%d",&b);
  A=a,B=b;

  pgcd(&a,&b);

  printf("\n pgcd(%d,%d)=%d\n\n",A,B,a);
}
