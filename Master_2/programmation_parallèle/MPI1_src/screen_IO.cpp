#include <cstdio>
#include <iostream>

#include "mpi.h"

int main(int argc, char *argv[]) {

  int nprocs,rank;
  int i;

  int ierr=sscanf(argv[1],"%d",&i);
  if (ierr!=1){
    std::cout << "Erreur de lecure" << std::endl;
  }
  else{
    std::cout << "entier : " << i << std::endl;
  }
  std::cin >> i;

  MPI_Init(NULL,NULL);
  MPI_Comm_rank(MPI_COMM_WORLD,&rank);
  MPI_Comm_size(MPI_COMM_WORLD,&nprocs);

  printf("I am process %d out of %d\n",rank,nprocs);

  MPI_Finalize();

}