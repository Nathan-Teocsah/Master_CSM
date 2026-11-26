#include <iostream>
#include <cmath>
#include "vect2.h"
using namespace std;


/*
Pour compiler e exécuter : 

g++ q2.cpp vect1.cpp  && a.out

*/

int main(){

    cout << "question 2"<<endl;

    Vect v1(3);
    v1.init(2);
    Vect v2;
    Vect v3;
    v3 = v2 = v1;
    cout << "v1 : ";
    v1.affiche();
    cout << "v2 : ";
    v2.affiche();
    cout << "v3 : ";
    v3.affiche();

    cout << endl;
    cout << "question 3"<<endl;

    v2.modif(2,35);
    v1.modif(1,3);
    cout << "v1 : ";
    v1.affiche();
    cout << "v2 : ";
    v2.affiche();
    cout << "v3 : ";
    v3.affiche();
    v3=v1;
    v3=v1=v2;
    cout << "v1 : ";
    v1.affiche();
    cout << "v2 : ";
    v1.affiche();
    cout << "v3 : ";
    v1.affiche();

    cout << endl;
    cout << "question 4 à 6"<<endl;

    v1.init(sqrt(2));
    v2.modif(0,sqrt(5));
    v2.modif(1,sqrt(5)+2);
    v2.modif(2,3+sqrt(6));
    cout << "v2-v1 : ";
    (v2-v1).affiche();
}