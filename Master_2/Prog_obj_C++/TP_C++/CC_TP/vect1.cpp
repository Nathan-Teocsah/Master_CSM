#include "vect2.h"
#include <iostream>
#include <cassert>
using namespace std;


Vect::Vect(int n):lg(n),val(new double[n]){
    cout<<"Création d'un vecteur "<<this<<endl;
}

void Vect::init(double c){
    for (int i=0;i<lg;i++) val[i] = c;
}

void Vect::affiche() const{
    cout << "vec = [ ";
    for (int i=0;i<lg-1;i++) cout<<val[i]<<", ";
    cout<<val[lg-1]<<" ]"<<endl;
}

Vect::Vect(const Vect& V): lg(V.lg), val(new double[lg]){
    // Le prototype n'est pas Vect(Vect) car ça impliquerai
    // de copier l'objet, ce qu'on est en train de définir justement
    for (int i=0;i<lg;i++){
        val[i] = V.val[i];
    }
}

Vect& Vect::operator=(const Vect& V){
    if (lg != V.lg){
        lg = V.lg;
        delete[] val;
        val = new double[V.lg];
    }
    
    for (int i=0;i<lg;i++){
        val[i] = V.val[i];
    }
    return *this;
}

int Vect::getlg(){
    return lg;
}

void Vect::modif(int i,double x){
    val[i] = x;
}


Vect Vect::operator -(const Vect& B) const{
    assert(lg == B.lg);
    Vect C(lg);
    for (int i=0; i<lg;i++){
        C.val[i] = val[i]-B.val[i];
    }
    return C;
};

