#include <stdio.h>

void imptabP(int n, int *t)
{
  int i = 0;
  for (int *p=t;p<n+t;p++)
  {
    printf("\n  *(t+%d) = %d\n",i++,*p);
  }
}
