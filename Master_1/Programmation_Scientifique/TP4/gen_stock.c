#include <stdio.h>
#include <stdlib.h> //Pour la fonction rand
#include <time.h> //Pour modifier le seed de la fonction rand en utilisant la fonction time()
#include "fonction.h"

int main()
{
  int n;

  printf("Algorithme renvoyant n entier aléatoire et les stockant dans un tableau M.\n");
  printf("Rentrer un entier n : ");
  scanf("%d",&n);
  
  int Mat[n];

  srand(time(NULL));
  for (int i=0;i<n;i++)
  {
    *(Mat+i)=rand();
  }
  
  imptabP(n,Mat);
  
}
