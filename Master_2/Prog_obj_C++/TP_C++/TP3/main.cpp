#include "vect3.h"
#include <iostream>

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
    cout<<V.getlg()<<endl;
    (U+V).affiche();
    Vect K(3);
    K.add(U,V);
    K.affiche();
    float a = 2.7;
    float a1 = 2;
    double d = 2.66;
    int b = 2;
    int c= 3;
    cout << prod(a,a1)<<endl;
    cout << prod(b,c) << endl;
    cout << prod(d,c) << endl;
}