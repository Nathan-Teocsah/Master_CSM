#include <stdio.h>
#include <stdlib.h> //Pour la fonction rand
#include <time.h> //Pour modifier le seed de la fonction rand en utilisant la fonction time()
#include "fonction.h"

int main()
{
  printf("Algorithme générant N nombre entier avec rand(), calculant la moyenne et l'écart-type de cette distribution.\n\n");
  
  int N;
  printf("N = ");
  scanf("%d",&N);
  
  float M[N];
  
  srand(time(NULL));
  for (int i=0;i<N;i++)
  {
    *(M+i)= (float)rand();
  }
 float e=0, m=0;
 moyenne(M,N,&m);
 ecartype(M,N,&e,&m,0); //derier argument si = 1 alors pas besoin de calculer la moyenne, et si =0 on calcul la moyenne dans cette fonction, ici la moyenne est calculée par moyenne.
 printf("\nMoyenne = %f\n",m);
 printf("Ecart-type = %f\n\n",e);
}
