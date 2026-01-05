#include <stdio.h>

void triplePointeur(int *pointeurSurNombre)

{

    *pointeurSurNombre = 3; // On multiplie par 3 la valeur de nombre

}

int main(int argc, char *argv[])

{

    int nombre = 5;
    
    pointeur = nullptr_t;

    //int *pointeur = &nombre; // pointeur prend l'adresse de nombre


    triplePointeur(pointeur); // On envoie pointeur (l'adresse de nombre) à la fonction

    printf("%d", *pointeur); // On affiche la valeur de nombre avec *pointeur


    return 0;

}



