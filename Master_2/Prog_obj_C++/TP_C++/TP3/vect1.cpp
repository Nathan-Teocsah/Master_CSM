#include "vect3.h"
#include <iostream>
#include <cassert>
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

Vect::Vect(const Vect& V): lg(V.lg), val(new double[lg]){
    // Le prototype n'est pas Vect(Vect) car ça impliquerai
    // de copier l'objet, ce qu'on est en train de définir justement
    for (int i=0;i<lg;i++){
        val[i] = V.val[i];
    }
}

Vect& Vect::operator=(const Vect V){
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

/*
int getlg(const Vect& V){
    return V.lg ;
}
*/

int Vect::getlg(){
    return lg;
}

Vect::~Vect(){
    delete[] val;
}


Vect Vect::operator+(Vect V){
    assert(lg==V.lg);
    Vect W(lg);
    for (int i=0;i<lg;i++){
        W[i] = val[i] + V[i];
    }
    return W;
}

void Vect::add(const Vect& A, const Vect& B){
    assert(A.lg==B.lg);
    if (lg != A.lg){
        delete [] val;
        lg = A.lg;
        val = new double[lg];
    }
    for (int i=0; i< lg; i++){
        val[i] = A.val[i] + B.val[i];
    }
}

template <class T1, class T2>
T1 prod(T1 A,T2 B){
    return A*B;
}

template int prod(int,int);
template float prod(float, float);
template double prod(double, int);
