#include <stdio.h>
#include <stdlib.h> //Pour la fonction rand
#include <time.h> //Pour modifier le seed de la fonction rand en utilisant la fonction time()
#include <math.h>
#include "fonction.h"

int main()
{
  printf("Algorithme générant N nombre entier avec rand(), calculant la moyenne et l'écart-type de cette distribution.\n\n");
  
  int N;
  printf("N = ");
  scanf("%d",&N);
  
  float M[N];
  
  srand(time(NULL)); //Pour réinitialiser "aléatoirement" le seed de la fonction rand
  float e=0, m=0;
  float a;
  for (int i=0;i<N;i++)
  {
    //*(M+i)= (float)rand();
    a = (float)rand();
    m = m + a/N;
    e = e + pow(a,2)/N;
  }
  e = sqrtf(e-pow(m,2));
 
 //moyenne(M,N,&m);
 //ecartype(M,N,&e,&m,0); //dernier argument si = 1 alors pas besoin de calculer la moyenne, et si =0 on calcul la moyenne dans cette fonction, ici la moyenne est calculée par moyenne.
 
 float rand_max = (float)RAND_MAX;
 float moy_th = (rand_max+1)/2; //Moyenne théorique
 float ec_th = sqrtf(pow(rand_max+1,2)-1)/sqrtf(12); //Ecart-type théorique
 
 printf("\nMoyenne = %e\n",m); //Moyenne de la distribution générée par rand()
 printf("Moyenne théorique = %e\n",moy_th);
 printf("Erreur = %e\n",fabs(m-moy_th));
 printf("Pourcentage d'erreur = %f \n\n",100*fabs(m-moy_th)/moy_th);
 
 printf("Ecart-type = %e\n",e); //Ecart-type de la distribution générée par rand()
 printf("Ecart-type théorique = %e\n",ec_th);
 printf("Erreur = %e\n",fabs(e-ec_th));
 printf("Pourcentage d'erreur = %f \n\n",100*fabs(e-ec_th)/ec_th);
 
 printf("RAND_MAX = %e\n\n",rand_max);
 
}
