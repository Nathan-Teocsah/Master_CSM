#include <stdio.h>
#include "matrix.h"

int main(){
int n, m;

printf("Algorithme calculant la somme de deux matrices.\n\n");
printf("Nombre de ligne(s) des matrices : ");
scanf("%d", &n);
printf("Nombre de colonne(s) des matrices : ");
scanf("%d", &m);

Matrix A;
mat_create(&A,n,m);
printf("\nInitialisation de la première matrice : \n");
mat_init(&A); 

Matrix B;
mat_create(&B,n,m);
printf("\nInitialisation de la deuxième matrice : \n");
mat_init(&B);

printf("\n");
Matrix Res;
mat_create(&Res,n,m);
matsum(A,B,&Res);
printf("A + B = \n");
mat_print(Res);
mat_free(Res); mat_free(A); mat_free(B);
}
