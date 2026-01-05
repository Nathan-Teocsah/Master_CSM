#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>


int main(void)
{
    int tab[5] = { 0 };
    const size_t n = sizeof tab / sizeof tab[0];
    FILE *fp = fopen("thomas.inp", "rb");

    if (fp == NULL)
    {
        fprintf(stderr, "Le fichier binaire.bin n'a pas pu être ouvert\n");
        return EXIT_FAILURE;
    }
    if (fread(&tab, sizeof tab[0], n, fp) != n)
    {
            fprintf(stderr, "Erreur lors de la lecture du tableau\n");
            return EXIT_FAILURE;
    }
    if (fclose(fp) == EOF)
    {
        fprintf(stderr, "Erreur lors de la fermeture du flux\n");
        return EXIT_FAILURE;        
    }

    for (unsigned i = 0; i < n; ++i)
        printf("tab[%u] = %d\n", i, tab[i]);

    return 0;
}

