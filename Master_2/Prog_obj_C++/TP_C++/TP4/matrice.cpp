#include <iostream>
#include <cassert>
#include "matrice3.h"
using namespace std;

Matrice::Matrice(int nbl, int nbc):nbl(nbl),nbc(nbc){
    val = new double*[nbl];
    for (int i=0; i<nbl;i++)
        val[i] = new double[nbc];
}

void Matrice::affiche() const{
    for (int i =0; i<nbl; i++){
        for (int j = 0; j<nbc; j++){
            cout << val[i][j] << " ";
        }
        cout << endl;
    }
}

void Matrice::init(double r){
    for (int i=0; i<nbl; i++){
        for (int j=0; j<nbc; j++){
            val[i][j] = r;
        }
    }
}

Matrice Matrice::operator+(const Matrice& B){
    assert(nbl==B.nbl);
    assert(nbc==B.nbc);
    Matrice C(nbl,nbc);
    for (int i=0; i<nbl;i++){
        for (int j=0; j<nbc; j++){
            C.val[i][j] = val[i][j]+B.val[i][j];
        }
    }
    return C;
}

Matrice::~Matrice(){
    for (int i=0;i<nbl;i++){
        delete [] val[i];
    }
    delete [] val;
}

Matrice::Matrice():nbl(0),nbc(0),val(nullptr){}

Matrice& Matrice::operator=(const Matrice& B){
    if (B.nbl != nbl || B.nbc != nbc){
        for (int i=0; i<nbl;i++){
            delete [] val[i];
        }
        if (nbl!=0){
            delete [] val;
        }
        nbl = B.nbl;
        nbc = B.nbc;
        val = new double*[nbl];
        for (int i=0; i<nbl;i++){
            val[i] = new double[nbc];
            for (int j=0;j<nbc;j++){
                val[i][j] = B.val[i][j];
            }
        }
    }
    else{
        for (int i=0; i<nbl;i++){
            for (int j=0;j<nbc;j++){
                val[i][j] = B.val[i][j];
            }
        }
    }
    return *this;
}

Matrice::Matrice(Matrice& A):nbl(A.nbl),nbc(A.nbc),val(new double*[nbl]){
    for (int i=0; i<nbl;i++){
        val[i] = new double[nbc];
        for (int j=0;j<nbc;j++){
            val[i][j] = A.val[i][j];
        }
    }
}


/*------- MATFULL -------*/

MatFull::MatFull():Matrice(){}

MatFull::MatFull(int nbl, int nbc):Matrice(nbl,nbc){}

MatFull::MatFull(MatFull& A):Matrice(A){};

MatFull::~MatFull(){
    delete this;
};

/*
MatFull MatFull::operator+(const MatFull& B) {
    Matrice A = Matrice(*this).Matrice::operator+(B);
    return MatFull(A);
};

MatFull& MatFull::operator=(const MatFull& B){
        Matrice(*this).Matrice::operator=(B);
        return *this;
};
*/
