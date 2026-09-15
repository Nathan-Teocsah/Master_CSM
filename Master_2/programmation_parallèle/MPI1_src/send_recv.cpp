#include <cstdio>
#include <iostream>

#include "mpi.h"

int main(int argc, char *argv[]) {

  int nprocs,rank;
  int M;
  double x;
  MPI_Status status;
  
  MPI_Init(NULL,NULL);
  MPI_Comm_rank(MPI_COMM_WORLD,&rank);
  MPI_Comm_size(MPI_COMM_WORLD,&nprocs);
  
  if (rank==0)
    {          
      M=42;
      x=2.5;
      MPI_Send(&M,1,MPI_INT,1,0,MPI_COMM_WORLD);
      MPI_Send(&x,1,MPI_DOUBLE,1,1,MPI_COMM_WORLD);
    }
  else if (rank==1)
    {
      MPI_Recv(&M,1,MPI_INT,0,0,MPI_COMM_WORLD,&status);
      std::cout << "status send : " << status.MPI_SOURCE <<  " receive : " << rank << std::endl;
      MPI_Recv(&x,1,MPI_DOUBLE,0,1,MPI_COMM_WORLD,&status);
      std::cout << "status send : " << status.MPI_SOURCE <<  " receive : " << rank << std::endl;
      M+=1;
      x=0.5*x;
    }
  
  std::cout << "Process " << rank << " M=" << M << " x=" << x << "\n";
    
  MPI_Finalize();

  return 0;
}
