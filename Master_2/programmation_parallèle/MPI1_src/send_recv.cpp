#include <cstdio>
#include <iostream>

#include "mpi.h"

int main(int argc, char *argv[]) {

  int nprocs,rank;
  int* M = (int*) calloc(2,sizeof(int));
  double x;
  MPI_Status status;
  
  MPI_Init(NULL,NULL);
  MPI_Comm_rank(MPI_COMM_WORLD,&rank);
  MPI_Comm_size(MPI_COMM_WORLD,&nprocs);
  
  if (rank==0)
    {          
      M[0]=42;
      x=2.5;
      double y = 4;
      MPI_Send(&y,1,MPI_DOUBLE,1,1,MPI_COMM_WORLD);
    }


    MPI_Bcast(&(M[0]),1,MPI_INT,0,MPI_COMM_WORLD);

  if (rank==1)
    {
      MPI_Recv(&x,1,MPI_DOUBLE,0,1,MPI_COMM_WORLD,&status);
      M[0]+=1;
      M[1] = 2;
      x=0.5*x;
    }
  
  std::cout << "Process " << rank << " M=" << M[0] << " x=" << x << "\n";
    
  MPI_Finalize();

  return 0;
}
