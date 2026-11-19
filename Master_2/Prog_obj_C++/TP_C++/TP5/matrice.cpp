#include <iostream>
#include <cassert>
#include "matrice3.h"
using namespace std;

#define MAX(a, b){a>b?a:b};

/*-------------- VEC ----------------*/

Vec::Vec(const int n):vector<double>(n){};

void Vec::init(const double d){
    int n = (*this).size();
    for (int i=0;i<n;i++){
        (*this)[i] = d;
    }
}

void Vec::affiche() const{
    cout << "Vec = [";
    int n = (*this).size();
    for (int i=0;i<n;i++){
        cout << (*this)[i] ;
        if (i < n-1)
            cout << ", ";
        else
            cout << "]" <<endl;
    }
}

Vec Vec::operator+(const Vec& V) const{
    int a=V.size();
    int b=(*this).size();
    int c = MAX(a,b);
    Vec X(c);
    for (int i=0;i<c;i++){
        if (i>= a)
            X[i] = (*this)[i];
        else if(i>=b)
            X[i] = V[i];
        else
            X[i] = (*this)[i]+V[i];
    }
    return X;
}

/*--------------- ERREUR -------------*/
const char* Mat_err::what() const{
    if (cas==0)
        return "Nombre de ligne négative";
    if (cas==1)
        return "Nombre de colonne négative";
    return "Nombre de ligne et de colonne négative";
}



/*-------------- MATRICE -------------*/

Matrice::Matrice():nbl(0),nbc(0),val(nullptr){}

Matrice::Matrice(const int nbl, const int nbc):nbl(nbl),nbc(nbc){
    if (nbl < 0 && nbc < 0){
        throw Mat_err(2);
    }
    else if (nbc < 0){
        throw Mat_err(1);
    }
    else if (nbl < 0){
        throw Mat_err(0);
    }
    val = new double*[nbl];
    for (int i=0; i<nbl;i++)
        val[i] = new double[nbc];
}


Matrice::Matrice(const Matrice& A):nbl(A.nbl),nbc(A.nbc),val(new double*[nbl]){
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

void Matrice::init(const double r){
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

double*& Matrice::operator[](const int i){
    return val[i];
}

double& Matrice::operator()(const int i,const int j){
    if ((nbc != 0) || (j<= i))
        return val[i][j];
    return val[j][i];
}



/*------- MATFULL -------*/

MatFull::MatFull():Matrice(){}

MatFull::MatFull(const int nbl, const int nbc):Matrice(nbl,nbc){}

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

MatSym::MatSym(const int n):Matrice(n,0){}

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

void MatSym::init(const double r){
    for (int i=0; i<nbl; i++){
        for (int j=0; j<=i; j++){
            val[i][j] = r;
        }
    }
}