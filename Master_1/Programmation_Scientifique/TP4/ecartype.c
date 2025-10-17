#include <stdio.h>
#include <math.h>

void ecartype(float *M,int N,float *p_e,float *p_m,int b)
{
  if (!((b==0)||(b==1)))
  {
    printf("\n\nAttention ! pour le dernier argument :\n 1 = il faut calculer la moyenne\n 0 = moyenne déjà calculée\n\n"); 
  }
  else
  {
    if (b==1) //Il faut donc calculer la moyenne
    {
      printf("On calcul la moyenne !");
      for (int i=0;i<N;i++)
      {
        *p_m = *p_m + *(M+i)/N;
      }
    }
    for (int i=0;i<N;i++) //Calcul de l'ecart-type au carré
    {
      *p_e = *p_e + pow(2,*(M+i)-*p_m)/N;
    }
    *p_e = sqrtf(*p_e); //ecart-type
  }
}
