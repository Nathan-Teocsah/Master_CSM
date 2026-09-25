#include "vect1.h"
#include <iostream>
using namespace std;

Vect::Vect(int n):lg(n),val(new double[n]){
    cout<<"Création d'un vecteur "<<this<<endl;
}

void Vect::init(double c){
    for (int i=0;i<lg;i++) val[i] = c;
}

void Vect::affiche(){
    cout << "vec = [ ";
    for (int i=0;i<lg-1;i++) cout<<val[i]<<", ";
    cout<<val[lg-1]<<" ]"<<endl;
}
