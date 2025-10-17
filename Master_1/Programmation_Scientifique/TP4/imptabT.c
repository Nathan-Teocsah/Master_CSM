#include <stdio.h>

void imptabT(int n, int *t)
{
  for (int i=0;i<n;i++)
  {
    printf("\n  t[%d] = %d\n",i,  *(t+i));
  }
}


