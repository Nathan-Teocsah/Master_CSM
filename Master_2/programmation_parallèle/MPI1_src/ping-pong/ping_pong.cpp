#include <iostream>
#include <cstdlib>
#include <fstream>
#include "mpi.h"

using namespace std;

int main(int argc, char *argv[]) {
    double total_time;

    int nprocs, rank;
    MPI_Status status;
    int M; // Nombre d'échange
    int N; // Nombre d'entier dans le tableau
    double* tab;
    MPI_Init(NULL,NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
    double start_time;

    if (rank==0){ 
        cout << "Nombre d'échanges : ";
        cin >> M;
        cout << "\nNombre de d'élément dans le tableau : ";
        cin >> N;
        tab = (double*) malloc(N*sizeof(double));
        MPI_Send(tab,N,MPI_DOUBLE,1,0,MPI_COMM_WORLD);
    }

    for (int i=0; i<N;i++){
        if (rank==1){ 
            MPI_Recv(tab,N,MPI_DOUBLE,0,0,MPI_COMM_WORLD,&status);
            cout << "rang " << rank << " reçu info du rang " << 1 << " byte/time = " << N*sizeof(double)/(MPI_Wtime()-start_time) << endl;
            start_time = MPI_Wtime();
            MPI_Send(tab,N,MPI_DOUBLE,0,0,MPI_COMM_WORLD);
        }
        if (rank==0){
            MPI_Recv(tab,N,MPI_DOUBLE,1,0,MPI_COMM_WORLD,&status);
            cout << "rang " << rank << " reçu info du rang " << 1 << " byte/time = " << N*sizeof(double)/(MPI_Wtime()-start_time) << endl;
            start_time = MPI_Wtime();
            MPI_Send(tab,N,MPI_DOUBLE,1,0,MPI_COMM_WORLD);
        }
    }

    MPI_Finalize();
}