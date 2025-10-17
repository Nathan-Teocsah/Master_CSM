#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
  int n;

  printf("Algorithme renvoyant n entier aléatoire.\n");
  printf("Rentrer un entier n : ");
  scanf("%d",&n);

  srand(time(NULL));
  for (int i=0;i<n;i++)
  {
    printf("%d ",rand());
  }
}
