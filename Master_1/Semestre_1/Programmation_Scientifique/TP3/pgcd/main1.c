#include <stdio.h>

int main()
{
  int a,b,A,B;
  

  printf("Algorithme pour calculer le pgcd de a et b.\n");
  printf("Entrer la valeur de a : "), scanf("%d", &a), printf("Entrer la valeur de b : "), scanf("%d",&b);
  A=a,B=b;

  void pgcd(int*i_a,int*i_b);
  pgcd(&a,&b);

  printf("\n pgcd(%d,%d)=%d\n\n",A,B,a);
  
}
