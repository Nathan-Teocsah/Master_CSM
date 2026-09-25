#include <iostream>
#include "vect1.h"
using namespace std;
int main(){
    Vect P(3);
    P.affiche();
    P.init(2);
    P.affiche();
    Vect Q(P);
    Q[0] = 0;
    P.affiche();
}