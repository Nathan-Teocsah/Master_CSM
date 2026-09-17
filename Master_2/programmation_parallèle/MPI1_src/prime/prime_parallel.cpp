#include <iostream>
#include <cstdlib>
#include <cmath>
#include <fstream>
#include "mpi.h"

using namespace std;

int main(int argc, char *argv[]) {

    double total_time;

    int nprocs, rank;
    MPI_Status status;
    int M;
    sscanf(argv[1],"%d",&M);
    MPI_Init(NULL,NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &nprocs);

    double start_time = MPI_Wtime();

    int number = 0;
    int jmax = M;
    int pas = 2*nprocs;

    int jmin = 3+2*rank;
    for (int j=jmin; j<=jmax; j=j+pas) {
        int prime = 1;
        int imax = floor(sqrt(j));
        for (int i=3; i<=imax; i=i+2) {
            if (j%i==0) {
                prime = 0;
                break;
            }
        }
        number += prime;
    }
    
    if (rank!=0){
        MPI_Send(&number,1,MPI_INT,0,0,MPI_COMM_WORLD);
    }

    if (rank == 0){
        int number_prov;
        number+=1;
        for (int np=1;np<nprocs;np++){
            MPI_Recv(&number_prov,1,MPI_INT,np,0,MPI_COMM_WORLD,&status);
            number += number_prov;
        }
        double end_time = MPI_Wtime(); // Fin de la mesure (tous les processus)
        double elapsed_time = end_time - start_time;
        cout << "(par) There are " << number << " prime numbers between 2 and " << M << endl;
        cout << "CPU time used for parallel computing : " << elapsed_time << " sec" << endl;
        string filename = "results_parallel.txt";
        ofstream output_file(filename, ios::app);
        if (output_file.is_open()) {
            output_file << M << " " << elapsed_time << endl;
            output_file.close();
        }
    }
    

    MPI_Finalize();
}
