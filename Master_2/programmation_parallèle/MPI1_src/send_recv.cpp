#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    MPI_Init(&argc, &argv);

    int rank, nprocs;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);

    // --- Étape 1 : Chaque processus génère ses données locales ---
    int local_data[] = {0, 1};          // rank 0
    int local_count = 2;
    if (rank == 1) {
        local_data[0] = 10; local_data[1] = 11; local_data[2] = 12;
        local_count = 3;
    } else if (rank == 2) {
        local_data[0] = 20;
        local_count = 1;
    }

    // --- Étape 2 : Préparer les tableaux pour MPI_Allgatherv ---
    // Tableau des tailles envoyées par chaque processus
    int *sendcounts = (int*) malloc(nprocs * sizeof(int));
    // Tableau des déplacements (en nombre d'éléments, pas en octets !)
    int *displs = (int*) malloc(nprocs * sizeof(int));

    // Rassembler les tailles locales (sendcounts)
    MPI_Allgather(
        &local_count, 1, MPI_INT,  // Chaque processus envoie sa taille locale
        sendcounts, 1, MPI_INT,     // Tous reçoivent les tailles dans sendcounts
        MPI_COMM_WORLD
    );

    // Calculer les déplacements (displs)
    displs[0] = 0;
    for (int i = 1; i < nprocs; i++) {
        displs[i] = displs[i - 1] + sendcounts[i - 1];
    }

    // --- Étape 3 : Calculer la taille totale ---
    int total_count = 0;
    for (int i = 0; i < nprocs; i++) {
        total_count += sendcounts[i];
    }

    // --- Étape 4 : Allouer le buffer de réception ---
    int *global_data = (int*) malloc(total_count * sizeof(int));

    // --- Étape 5 : Appeler MPI_Allgatherv ---
    MPI_Allgatherv(
        local_data, local_count, MPI_INT,  // Données locales à envoyer
        global_data, sendcounts, displs, MPI_INT, // Buffer global pour recevoir
        MPI_COMM_WORLD
    );

    // --- Étape 6 : Afficher les résultats sur chaque processus ---
    printf("Process %d: global_data = [", rank);
    for (int i = 0; i < total_count; i++) {
        printf("%d", global_data[i]);
        if (i < total_count - 1) printf(", ");
    }
    printf("]\n");

    // --- Libérer la mémoire ---
    free(sendcounts);
    free(displs);
    free(global_data);

    MPI_Finalize();
    return 0;
}