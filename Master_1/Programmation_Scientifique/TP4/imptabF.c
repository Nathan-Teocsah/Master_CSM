#include <stdio.h>

void imptabF(int n, float *t)
{
  for (int i=0;i<n;i++)
  {
    printf("\n  *(t+%d) = %f\n",i,*(t++));
  }
}
