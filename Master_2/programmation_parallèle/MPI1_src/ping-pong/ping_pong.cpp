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
        cout << "--------- PING-PONG ---------\n";
        cout << "Nombre d'échanges : \n" ;
        cin >> M;
        cout << "Nombre d'élément dans le tableau :\n";
        cin >> N;
        MPI_Send(&N,1,MPI_INT,1,0,MPI_COMM_WORLD);
        MPI_Send(&M,1,MPI_INT,1,0,MPI_COMM_WORLD);
    }
    else{
        MPI_Recv(&N,1,MPI_INT,0,0,MPI_COMM_WORLD,&status);
        MPI_Recv(&M,1,MPI_INT,0,0,MPI_COMM_WORLD,&status);
    }

    tab = (double*) malloc(N*sizeof(double));

    for (int i=0; i<M;i++){
        if (rank==0){ 
            start_time = MPI_Wtime();
            MPI_Send(tab,N,MPI_DOUBLE,1,0,MPI_COMM_WORLD);
            MPI_Recv(tab,N,MPI_DOUBLE,1,0,MPI_COMM_WORLD,&status);
        }
        else{
            MPI_Recv(tab,N,MPI_DOUBLE,0,0,MPI_COMM_WORLD,&status);
            start_time = MPI_Wtime();
            MPI_Send(tab,N,MPI_DOUBLE,0,0,MPI_COMM_WORLD);
        }
        
        cout << "rang " << rank << " : aller-retour " << i
             << " = " << N*sizeof(double)/(MPI_Wtime()-start_time) << " octets/s" << endl;
    }

    MPI_Finalize();
}