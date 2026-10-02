#include <iostream>
#include "vect2.h"
using namespace std;
int main(){
    Vect V(2);
    V.affiche();
    Vect U;
    Vect W;
    W=U=V;
    W[0] = 2;
    V.affiche();
    U[0] = 3.2;
    V.affiche();
}