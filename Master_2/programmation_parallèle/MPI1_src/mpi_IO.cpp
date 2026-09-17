#include <iostream>
#include "mpi.h"

int main(int argc, char *argv[]) {

    int nprocs, rank;
    int i;
    MPI_Status status;

    MPI_Init(NULL,NULL);

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
    
    std::cout << "Je suis rank " << rank << ", entrer un entier : " << std::endl;
    std::cin >> i;

    std::cout<< "Entier " << rank << " : " << i << std::endl;

    MPI_Finalize();

    return 0;
}