#include <stdio.h>
#include <math.h>

float pol(float *t,float x){
  return t[3]*powf(x,3)+t[2]*powf(x,2)+t[1]*x+t[0];
}

int main(){
  float t[4] = {200,-100,-1082,1045};
  
  
  float prec = 0.001;
  float a = -4,b= 3;
  float m = (a+b)/2;
  
  while (b-a > prec){
    if (pol(t,a)*pol(t,m)<0){
      b = m;
    }
    else{
      a = m;
    }
    m = (a+b)/2;
  }
  
  printf("Le zéro entre -4 et 3, est : %f\n\n",m);
}
