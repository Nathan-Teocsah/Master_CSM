#include <stdio.h>
#include <stdlib.h> //Pour la fonction rand
#include <time.h> //Pour modifier le seed de la fonction rand en utilisant la fonction time()
#include "fonction.h"

int main()
{
  int n;

  printf("Algorithme générant n entier aléatoire, les stock dans un tableau et affiche les 10 derniers.\n\n");
  printf("Rentrer un entier n > 10 : ");
  scanf("%d",&n);
  
  if (n<10)
  {
    printf("n est trop petit !\n");
  }
  else
  {
    int Mat[n];

    srand(time(NULL));
    for (int i=0;i<n;i++)
    {
      *(Mat+i)=rand();
    }
    
    printf("\nAffichage avec imptabP :\n");
    imptabP(10,Mat+n-10);
    printf("\n\n");
    printf("Affichage avec imptabT : \n");
    imptabT(10,Mat+n-10);
  }
  
}
