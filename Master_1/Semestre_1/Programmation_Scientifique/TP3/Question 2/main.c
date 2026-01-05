#include <stdio.h>
#include <math.h>

int rroot(double, double, double, double*, double*);

int main()
{
  double a, b, c, xp, xm;
  


  printf("Résolution de l'équation ax^2+bx+c=0\n");
  printf("Enter a, b, c :\n"); 
  scanf("%lf %lf %lf", &a, &b, &c);
  

  int nsol = rroot(a,b,c,&xp,&xm);
  
 
  if (nsol==0) 
    {
      printf("\n Il n'y a pas de solution \n\n");
    }
  else if (nsol==1) 
    {
      printf("\n Il y a une solution : %lf \n\n", xp);
    }
  else
    {
      printf("\n Il y a 2 solutions : %lf et %lf \n\n", xp, xm);
    }
}
