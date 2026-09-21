#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

 typedef struct {
      double x, y;
      int On_Boundaries;
  } Sommet;

int main(int argc, char **argv) {
    MPI_Init(&argc, &argv);

    int rank, nprocs;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);

    // Chaque processus génère des sommets locaux
    int N = 8,M=6;
    Sommet* local_sommet = (Sommet*) malloc((M+1)*((N-rank)/nprocs+1)*sizeof(Sommet));
    int local_count = 0;
    for(int i = rank; i < N+1; i=i+nprocs){//Boucle noeud en x
        for (int j = 0; j < M+1; j++)//Bouvle n noued en y
        {
            local_sommet[local_count].x = rank+(double) i/10;
            local_sommet[local_count].y = rank+(double) j/10;
            local_sommet[local_count].On_Boundaries = i*(M+1)+j;
            local_count++;
        }
    }

    // --- Préparer sendcounts et displs en OCTETS ---
    int *sendcounts =(int*) malloc(nprocs * sizeof(int)); // sendcounts en octets
    int *displs =(int*) malloc(nprocs * sizeof(int));     // displs en octets

    // Rassembler les tailles locales (en nombre de Sommet)
    int *local_counts =(int*) malloc(nprocs * sizeof(int));
    MPI_Allgather(&local_count, 1, MPI_INT, local_counts, 1, MPI_INT, MPI_COMM_WORLD);

    // Calculer sendcounts et displs en octets
    sendcounts[0] = local_counts[0] * sizeof(Sommet);
    displs[0] = 0;
    for (int i = 1; i < nprocs; i++) {
        sendcounts[i] = local_counts[i] * sizeof(Sommet);
        displs[i] = displs[i - 1] + sendcounts[i - 1];
    }

    // Calculer la taille totale en octets
    int total_bytes = 0;
    for (int i = 0; i < nprocs; i++) {
        total_bytes += sendcounts[i];
    }

    // Allouer global_sommets en octets
    Sommet *global_sommets =(Sommet*) malloc(total_bytes);

    // --- Appel à MPI_Allgatherv avec MPI_BYTE ---
    MPI_Allgatherv(
        local_sommet, local_count * sizeof(Sommet), MPI_BYTE, // sendcount en octets
        global_sommets, sendcounts, displs, MPI_BYTE,           // recvcounts et displs en octets
        MPI_COMM_WORLD
    );

    // --- Afficher les résultats ---
    printf("Process %d: %d sommets\n", rank,local_count);
    if (rank==0){
    printf("---------------\n");
    for (int s = 0; s < total_bytes / sizeof(Sommet); s++) {
        int J = s%(M+1);
        int I = (s-J)/(M+1);
        int np = I%nprocs;
        int k = I/nprocs;
        int iter_Sommet = k*(M+1)+J;
        //Sommet loc_som = global_sommets[displs[np]/sizeof(Sommet)-1+iter_Sommet];
        Sommet loc_som = global_sommets[s];
        int i = ((int) 10*loc_som.x) - 10*((int) loc_som.x);
        int S = loc_som.On_Boundaries;
        J = S%(M+1);
        I = (S-J)/(M+1);
        np = I%nprocs;
        k = (I-np)/nprocs;
        printf("i = %d, j = %d et k = %d et s = %d\n",I,J,k,k*(M+1)+J);
        printf("rank %d Sommet %d = (%.1f, %.1f, %d)\n",
              np, s, iter_Sommet, loc_som.x, loc_som.y, loc_som.On_Boundaries);
    }
    printf("---------------\n");
    }

    // Libérer la mémoire
    free(local_counts);
    free(sendcounts);
    free(displs);
    free(global_sommets);

    MPI_Finalize();
    return 0;
}