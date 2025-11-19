#include <stdio.h>
#include <stdlib.h>
#include "header.h"


int main(){

FILE *fp = fopen("thomas.inp", "r");
if (fp == NULL)
    {
        fprintf(stderr, "Le fichier texte.txt n'a pas pu être ouvert\n");
        return EXIT_FAILURE;
    }
    
int n = dim(fp);
Matrix T, b;

T.nrow = n;
b.nrow = n;

T.mat = malloc(n*3*sizeof(*T.mat));
b.mat = malloc(n*sizeof(*b.mat));

get_matrix(fp,&T,&b);
printf("b = ");
mat_print(b);

if (fclose(fp) == EOF)
    {
        fprintf(stderr, "Erreur lors de la fermeture du flux\n");
        return EXIT_FAILURE;        
    }

}
