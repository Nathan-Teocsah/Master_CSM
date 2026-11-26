#include <iostream>
#include <cassert>
#include "matrice4.h"
using namespace std;


Matrice::Matrice():nbl(0),nbc(0),val(nullptr){}

Matrice::Matrice(int nbl, int nbc):nbl(nbl),nbc(nbc){
    val = new double*[nbl];
    for (int i=0; i<nbl;i++)
        val[i] = new double[nbc];
}


Matrice::Matrice(Matrice& A):nbl(A.nbl),nbc(A.nbc),val(new double*[nbl]){
    for (int i=0; i<nbl;i++){
        val[i] = new double[nbc];
        for (int j=0;j<nbc;j++){
            val[i][j] = A.val[i][j];
        }
    }
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

Matrice::~Matrice(){
    for (int i=0;i<nbl;i++){
        delete [] val[i];
    }
    delete [] val;
}


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



/*------- MATFULL -------*/

MatFull::MatFull():Matrice(){}

MatFull::MatFull(int nbl, int nbc):Matrice(nbl,nbc){}

MatFull::MatFull(const MatFull& A):Matrice(A.nbl,A.nbc){
    for (int i = 0; i<nbl; i++){
        for (int j=0; j<nbc;j++){
            val[i][j] = A.val[i][j];
        }
    }
};

MatFull MatFull::operator+(const MatFull& B){
    assert(nbl==B.nbl);
    assert(nbc==B.nbc);
    MatFull C(nbl,nbc);
    for (int i=0; i<nbl;i++){
        for (int j=0; j<nbc; j++){
            C.val[i][j] = val[i][j]+B.val[i][j];
        }
    }
    return C;
}

/*------- MATSYM -------*/

MatSym::MatSym():Matrice(){}

MatSym::MatSym(int n):Matrice(n,0){}

MatSym::MatSym(const MatSym& A):Matrice(A.nbl,0){
    for (int i=0;i<nbl;i++){
        val[i] = new double[i+1];
    }
};

MatSym MatSym::operator+(const MatSym& B){
    assert(nbl==B.nbl);
    assert(nbc==B.nbc);
    MatSym C(nbl);
    for (int i=0; i<nbl;i++){
        for (int j=0; j<=i; j++){
            C.val[i][j] = val[i][j]+B.val[i][j];
        }
    }
    return C;
}

void MatSym::affiche() const{
    for (int i =0; i<nbl; i++){
        for (int j = 0; j<=i; j++){
            cout << val[i][j] << " ";
        }
        cout << endl;
    }
}

void MatSym::init(double r){
    for (int i=0; i<nbl; i++){
        for (int j=0; j<=i; j++){
            val[i][j] = r;
        }
    }
}