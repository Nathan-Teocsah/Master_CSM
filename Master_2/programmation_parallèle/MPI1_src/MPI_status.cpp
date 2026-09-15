/* Example of use of status in MPI_Recv:
Node 0 sends half of expected data
Node 1 initializes vector to receive data
Half of the vector elements are unchanged
Real number of received data is given by MPI_Get_count
This code works for 2 processes only, otherwise calls MPI_Abort
*/

#include <cstdio>
#include <cstdlib>
#include "mpi.h"
using namespace std;

int main () {

  MPI_Init(NULL,NULL);

  int nprocs, rank;
  MPI_Comm_size(MPI_COMM_WORLD,&nprocs);
  MPI_Comm_rank(MPI_COMM_WORLD,&rank);

  if (nprocs != 2) {
    MPI_Abort(MPI_COMM_WORLD, 666);
    MPI_Finalize();
    return 0;
  }
  
  if (rank==0) {
    int M;
    cout << "Enter number of doubles to send ";
    cin >> M;
    double *x;
    x = new double [M];
    srand(time(NULL));
    printf("Initialized data \n");
    for (int i=0; i<M; i++) {
      x[i] = (double) rand()/RAND_MAX;
      printf("x[%d]=%12.3e ",i,x[i]);
    }
    printf("\n Send half of data! \n");
    MPI_Send(&M,1,MPI_INT,1,0,MPI_COMM_WORLD);
    MPI_Send(x,M/2,MPI_DOUBLE,1,42,MPI_COMM_WORLD);
  } else {
    MPI_Status status;
    int m_size;
    int n;
    MPI_Recv(&n,1,MPI_INT,0,0,MPI_COMM_WORLD,&status);
    printf(" Expected size of message = %d\n",n);
    double *x;
    x = new double [n];
    MPI_Recv(x,n,MPI_DOUBLE,0,42,MPI_COMM_WORLD,&status);
    printf("Received data\n");
    for (int i=0; i<n; i++) {
      printf("x[%d]=%12.3e ",i,x[i]);
    }
    printf("\n Rank of the source = %d\n",status.MPI_SOURCE);
    printf(" Tag of the message = %d\n",status.MPI_TAG);
    MPI_Get_count(&status,MPI_DOUBLE,&m_size);
    printf(" Real size of message = %d\n",m_size);
  }

  MPI_Finalize();

  return 0;
}
