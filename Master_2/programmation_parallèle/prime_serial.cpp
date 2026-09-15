#include <iostream>
#include <cstdlib>
#include <cmath>
#include <ctime>
using namespace std;

int main () {

  cout << "Search number of primes up to M, enter M ";
  int M;
  cin >> M;
    
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
  cout << "\nCPU time used: "
       << (double)(c_end-c_start) / CLOCKS_PER_SEC << " sec" << endl;
    
  cout << "There are " << number << " prime numbers between 2 and " << jmax << endl;

  return 0;
}
