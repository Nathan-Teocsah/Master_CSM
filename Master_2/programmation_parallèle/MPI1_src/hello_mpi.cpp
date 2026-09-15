#include <cstdio>
#include "mpi.h"

int main() {

  int nprocs,rank;

  MPI_Init(NULL,NULL);
  MPI_Comm_rank(MPI_COMM_WORLD,&rank);
  MPI_Comm_size(MPI_COMM_WORLD,&nprocs);

  printf("I am process %d out of %d\n",rank+1,nprocs);

  MPI_Finalize();

  return 0;
}
