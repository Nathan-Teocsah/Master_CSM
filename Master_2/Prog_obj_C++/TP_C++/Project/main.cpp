#include <iostream>
#include "TFourier.h"
using namespace std;
int main(){
    Complexe x;
    Complexe y(2.2);
    Complexe z(3.5,2);

    y.affiche();
    z.affiche();
    (z.conjugate()).affiche();
    (x+y).affiche();
    (x-y).affiche();
    (x*y).affiche();
    x+=y;
    x.affiche();
    x*=y;
    x.affiche();
    x/=z;
    x.affiche();
    y.affiche();
    cout << (x==x) << endl;
    cout << (x==y) << endl;
    cout << (x!=x) << endl;
    cout << (x!=y) << endl;
}