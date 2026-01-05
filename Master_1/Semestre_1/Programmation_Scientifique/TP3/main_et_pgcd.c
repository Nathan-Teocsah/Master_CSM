#include <stdio.h>

void main()
{
int a,b,A,B;

printf("Algorithme pour calculer le pgcd de a et b.\n");
printf("Entrer la valeur de a : "), scanf("%d", &a), printf("Entrer la valeur de b : "), scanf("%d",&b);
A=a,B=b;

int M;
while (a!= b)
{
  if (a<b)
    {
      M=b, b=a, a=M-b;
    }
  else
    {
      a = a-b;
    }
}

printf("\n pgcd(%d,%d) = %d \n\n",A,B,a);
}
