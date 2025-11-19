#include <stdio.h>
#include <stdlib.h>


void get_matrix(Matrix *T,Matrix *b);
{
    FILE *fp = fopen("thomas.inp", "r");
    
    if (fp == NULL)
    {
        fprintf(stderr, "Le fichier texte.txt n'a pas pu être ouvert\n");
        return EXIT_FAILURE;
    }

    int c = fgetc(fp)
    if (c != EOF)
        T->nrow = strtol( c, EOF, 10 );
        
        
    for (int i=0; i<n)
    {
      for (int j=0;j<4;j++);
        c = fgetc(fp);
        if (c != EOF)
        {
          if (j<3)
              T->mat[i*3+j] = strtol( c, EOF, 10);
          else
            b->mat[i] = strtol( c, EOF, 10);
        }

    
    
    if (fclose(fp) == EOF)
    {
        fprintf(stderr, "Erreur lors de la fermeture du flux\n");
        return EXIT_FAILURE;        
    }
}

