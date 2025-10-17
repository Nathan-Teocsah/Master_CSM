#include <stdio.h>
#include <math.h>

void main()
{

  double a,b,c;
  
  printf("Résolution de l'équation ax^2+bx+c=0\n");
  printf("Entrer a : "), scanf("%lf", &a), printf("Entrer b : "), scanf("%lf", &b), printf("Entrer c : "), scanf("%lf", &c);
  
  double bp = b/2;
  double D = bp*bp-a*c;
  
  if (D <0)
    {
      printf("\n Il n'y a pas de solutions\n\n");
    }
  else if (D==0)
    {
      double x = -bp/a;
      printf("\n Il y a une solution : %lf\n",x);
      printf("Erreur (dans l'équation) pour la solution trouvée : %23.16e\n\n",a*x*x+b*x+c);
    }
  else
    {
      double xp = (-bp+sqrt(D))/a, xm = (-bp-sqrt(D))/a;
      printf("\n Il y a 2 solutions : %lf et %lf\n",xp,xm);
      printf("Erreur (dans l'équation) pour la solution la plus grande : %23.16e\n",a*xp*xp+b*xp+c);
      printf("Erreur (dans l'équation) pour la solution la plus petite : %23.16e\n\n",a*xm*xm+b*xm+c);
    }

}
