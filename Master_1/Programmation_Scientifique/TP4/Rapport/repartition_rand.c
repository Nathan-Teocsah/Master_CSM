#include <stdio.h>
#include <stdlib.h> //Pour la fonction rand
#include <time.h> //Pour modifier le seed de la fonction rand en utilisant la fonction time()
#include "fonction.h"

int main(){
  int N, nbint;

  printf("Algorithme générant N nombre entier avec rand() et regarde combien se trouve dans chacun des nbint intervalle \n\n");
  printf("N = ");
  scanf("%d",&N);
  printf("\n nbint = ");
  scanf("%d",&nbint);

  int q = RAND_MAX/nbint, r = RAND_MAX%nbint;
  int taille;
  if (r==0)
  {
    taille = q;
  }
  else
  {
    taille = q+1;
  }

  int a, i, *p1, *p2, tab_rep[nbint], pourc_rep[nbint];
  for (int i=0;i<nbint;i++){*(tab_rep + i)=0;} //Initialisation à 0 du tableau stockant le nombre de nombres généré aléatoirement se trouvant dans chacun des intervalles.
  
  srand(time(NULL));
  for (int c=0;c<N;c++)
  {
    a = rand();
    q = a/taille, r = a%taille;
    
    p = tab_rep + q;
    *p = *p+1;
  }
  imptabP(nbint,tab_rep);
}
