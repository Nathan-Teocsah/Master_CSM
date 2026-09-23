#include <mpi.h>
#include <cstdio>

#define NB_CHAMPS 4   // (rank, i, j, i*M+j)

int main(int argc, char **argv) {
    MPI_Init(&argc, &argv);

    int rank, nprocs;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);

    int N = 8, M = 6;

    // 1) Sommets locaux dans un BUFFER CONTIGU (obligatoire pour MPI)
    int my_rows = 0;
    for (int i = rank; i < N; i += nprocs) my_rows++;

    int local_count = my_rows * M;
    int local_ints  = NB_CHAMPS * local_count;

    int (*local_sommet)[NB_CHAMPS] = new int[local_count][NB_CHAMPS];

    int k = 0;
    for (int i = rank; i < N; i += nprocs) {
        for (int j = 0; j < M; j++) {
            local_sommet[k][0] = rank;
            local_sommet[k][1] = i;
            local_sommet[k][2] = j;
            local_sommet[k][3] = i * M + j;
            k++;
        }
    }

    // 2) recvcounts et displs en NOMBRE D'INT
    int *recvcounts = new int[nprocs];
    int *displs     = new int[nprocs];

    MPI_Allgather(&local_ints, 1, MPI_INT,
                  recvcounts, 1, MPI_INT, MPI_COMM_WORLD);

    displs[0] = 0;
    int total_ints = 0;
    for (int p = 0; p < nprocs; p++) {
        if (p > 0) displs[p] = displs[p - 1] + recvcounts[p - 1];
        total_ints += recvcounts[p];
    }
    int total_sommets = total_ints / NB_CHAMPS;

    // 3) Buffer de réception CONTIGU
    int (*global_sommets)[NB_CHAMPS] = new int[total_sommets][NB_CHAMPS];

    MPI_Allgatherv(local_sommet, local_ints, MPI_INT,
                   global_sommets, recvcounts, displs, MPI_INT,
                   MPI_COMM_WORLD);

    // 4) Affichage
    printf("Process %d: %d sommets\n", rank, local_count);

    if (rank == 0) {
        printf("---------------\n");
        for (int p = 0; p < nprocs; p++) {
            int nb_sommets_p = recvcounts[p] / NB_CHAMPS;
            for (int s = 0; s < nb_sommets_p; s++) {
                int *som = global_sommets[displs[p] / NB_CHAMPS + s];
                printf("rank %d Sommet %d = (%d, %d, %d)\n",
                       som[0], som[3], som[1], som[2], som[3]);
            }
        }
        printf("---------------\n");
    }

    // 5) Libération
    delete[] local_sommet;
    delete[] global_sommets;
    delete[] recvcounts;
    delete[] displs;

    MPI_Finalize();
    return 0;
}