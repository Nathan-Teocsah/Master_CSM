#include <iostream>
#include <cstdlib>
#include <cmath>
#include <fstream>
#include <ctime>
using namespace std;

int main(int argc, char *argv[]) {
    
  int M;
  sscanf(argv[1],"%d",&M);
  int number = 1;
  int jmin = 3;
  int jmax = M;
    
  clock_t c_start = clock();
  for (int j=jmin; j<=jmax; j=j+2) {
    int prime = 1;
    int imax = floor(sqrt(j));
    for (int i=3; i<=imax; i=i+2) {
      if (j%i==0) {
	prime = 0;
	break;
      }
    }
    //    if(prime==1) printf("%d\n",j);
    number += prime;
  }
  clock_t c_end = clock();
    
  cout << "(ser) There are " << number << " prime numbers between 2 and " << jmax << endl;
  double total_time = (double)(c_end-c_start) / CLOCKS_PER_SEC;
  cout << "CPU time used for serial computing: "
       << total_time << " sec" << endl;

  string filename = "results_serial.txt";
  ofstream output_file(filename, ios::app);
  if (output_file.is_open()) {
      output_file << M << " " << total_time << endl;
      output_file.close();
  }

}
