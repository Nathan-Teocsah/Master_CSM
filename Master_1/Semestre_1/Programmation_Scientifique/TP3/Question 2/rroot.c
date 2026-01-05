#include <stdio.h>
#include <math.h>

int rroot(double a, double b, double c, double *p_xp, double *p_xm)
{
  
  double bp = b/2;
  double D = bp*bp-a*c;
  
  if (D <0)
    {
      return 0;
    }
  else if (D==0)
    {
      *p_xp = -bp/a;
      *p_xm = -bp/a;
      return 1;
    }
  else
    {
      *p_xp = (-bp+sqrt(D))/a, *p_xm = (-bp-sqrt(D))/a;
      return 2;
    }
}
