#include <stdio.h>
int i=3;
int main() 
{
void f2();
void f3();

int i=1;
printf("%d \n",i);
/* Appel a f2 et f3, fonctions sans arguments */
f2();
f3();
printf("%d %d %d \n",i);
}
