#include <iostream>
#include <cstdlib>
#include <fstream>
#include "mpi.h"

using namespace std;

int main(int argc, char *argv[]) {
    double total_time;

    int nprocs, rank;
    int ndim = 2, mdim = 3;
    int** A = new int* [ndim];
    for (int i=0; i<ndim; ++i) {
        A[i] = new int [ndim];
    }
    MPI_Status status;
    MPI_Init(NULL,NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
    
    
    if (rank==0){
        for (int i=0;i<ndim;i++){
            for (int j=0;j<mdim;j++){
                A[i][j]=i*mdim+j;
            }
        }
        MPI_Send(A,ndim*mdim,MPI_INT,1,0,MPI_COMM_WORLD);
    }
    if (rank==1){
        MPI_Recv(A,ndim*mdim,MPI_INT,0,0,MPI_COMM_WORLD,&status);
        for (int i=0;i<ndim;i++){
            for (int j=0;j<mdim;j++){
                cout << A[i][j] << endl;
            }
        }
    }


    MPI_Finalize();

}