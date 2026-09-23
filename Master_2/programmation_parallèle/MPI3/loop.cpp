#include <iostream>
#include "mpi.h"
#include <random>

using namespace std;

int main(int argc, char *argv[]) {
    int nprocs, rank;
    int nloop,N;
    double* tab;
    MPI_Status status;
    MPI_Init(NULL,NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
    
    if (rank==0){
        random_device rd;
        default_random_engine eng(rd());
        std::uniform_real_distribution<double> dist(0.0, 1.0);
        cout << "--------- LOOP-MPI3 ---------\n";
        cout << "nloop : \n" ;
        cin >> nloop;
        cout << "N :\n";
        cin >> N;
        tab = new double[N];
        for (int i=0;i<N;i++){
            tab[i] = dist(eng);
        }
        MPI_Send(tab,N,MPI_DOUBLE,1,0,MPI_COMM_WORLD);
    }

    MPI_Bcast(&N,1,MPI_INT,0,MPI_COMM_WORLD);
    MPI_Bcast(&nloop,1,MPI_INT,0,MPI_COMM_WORLD);
    if (rank != 0) tab = new double[N];
    

    int rank_suiv = rank+1;
    if (rank_suiv==nprocs) rank_suiv = 0;

    int rank_prec = rank-1;
    if (rank_prec==-1) rank_prec = 0;
    for (int i=0;i<nloop;i++){
        MPI_Recv(tab,N,MPI_DOUBLE,rank_prec,0,MPI_COMM_WORLD,&status);        
        MPI_Send(tab,N,MPI_DOUBLE,rank_suiv,0,MPI_COMM_WORLD);
    }

    delete[] tab;
    MPI_Finalize();

}