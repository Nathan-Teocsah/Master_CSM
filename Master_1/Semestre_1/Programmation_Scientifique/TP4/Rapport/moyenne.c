#include <stdio.h>

void moyenne(float *M,int N, float *p_m)
{
  for (int i=0;i<N;i++)
  {
    *p_m = *p_m + *(M+i)/N;
  }
}
