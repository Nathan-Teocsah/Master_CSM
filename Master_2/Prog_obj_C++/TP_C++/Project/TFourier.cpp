#include <iostream>
#include <math.h>
#include "TFourier.h"
using namespace std;


/*=========== Classe COMPLEXE_ERROR =========*/
const char* Complexe_error::what() const{
    // 0 : division par 0
    if (cas==0)
        return "Division par 0 !";
    return "Exception non géré";
};

/*=========== Classe COMPLEXE ===========*/

/*----- constructeur ------*/
Complexe::Complexe():re(0),im(0){};
Complexe::Complexe(const double re, const double im):re(re),im(im){};
Complexe::Complexe(const Complexe& z):re(z.re),im(z.im){};

/*---- accesseur ----*/
double Complexe::real() const{return re;};
double Complexe::imag() const{return im;};
void Complexe::affiche() const{cout << re <<"+i"<<im<<endl;};

/*---- conjugué ----*/
Complexe Complexe::conjugate() const{return Complexe(re,-im);};
Complexe Complexe::exp() const{
    double norme = std::exp(re);

    return Complexe(norme*std::cos(im),norme*std::sin(im));
};

/*--- surcharge d'opérateur ----*/
Complexe Complexe::operator+(const Complexe& z) const{
    return Complexe(z.re+re,z.im+im);
};
Complexe Complexe::operator-(const Complexe& z) const{
    return Complexe(re-z.re,im-z.im);
};
Complexe Complexe::operator*(const Complexe& z) const{
    return Complexe(re*z.re,im*z.im);
};
Complexe Complexe::operator/(const Complexe& z) const{
    if (z==0){//On throw une erreur lorsque l'on divise par 0
        throw Complexe_error();
    }
    double norme2 = z.re*z.re + z.im*z.im;
    double a = re * z.re - im * z.im;
    double b = im * z.re - z.im * re;
    return Complexe(a/norme2,b/norme2);
};

Complexe Complexe::operator+=(const Complexe& z){
    re +=z.re;
    im += z.im;
    return *this;
};
Complexe Complexe::operator-=(const Complexe& z){
    re -=z.re;
    im -= z.im;
    return *this;
};
Complexe Complexe::operator*=(const Complexe& z){
    re *=z.re;
    im *= z.im;
    return *this;
};
Complexe Complexe::operator/=(const Complexe& z){
    if (z==0){//On throw une erreur lorsque l'on divise par 0
        throw Complexe_error();
    }
    double norme2 = z.re*z.re + z.im*z.im;
    re = (re * z.re - im * z.im)/norme2;
    im = (im * z.re - z.im * re)/norme2;
    return *this;
};
bool Complexe::operator==(const Complexe& z) const{
    if (re==z.re && im==z.im) return true;
    return false;
};
bool Complexe::operator!=(const Complexe& z) const{
    if (re!=z.re || im!=z.im) return true;
    return false;
};


/*============ CLASSE TFOURIER ============*/

FTVector::FTVector():f(nullptr),poly(vector<Complexe>(0)){};
FTVector::FTVector(Complexe (**p_f)(double)):f(p_f),poly(vector<Complexe>(0)){};
FTVector::FTVector(const vector<Complexe>& poly):f(nullptr),poly(poly){};  
FTVector::FTVector(const FTVector& V):f(V.f){
    if (f==nullptr){
        poly = vector<Complexe>(V.poly.size());
        for (int i=0; i<poly.size();i++)
            poly[i] = V.poly[i];
    }
    else
        poly = vector<Complexe>(0);
}; 

void FTVector::FourierDiscrete(int n){
    if (poly.size()!=0)
        n = poly.size();
    else if (n!=0 && f){
        poly = vector<Complexe>(n);
        for (int i=0;i<n;i++)
            poly[i] = *f(i/n);
    }
    else{
        cout << "rien a transformer !!" << endl;
    }
};
void FTVector::FourierInverse(){};
