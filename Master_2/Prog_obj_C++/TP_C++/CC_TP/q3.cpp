#include <iostream>
#include <cmath>
#include "matrice4.h"
#include "vect2.h"
using namespace std;

/*
Pour compiler e exécuter : 

g++ q3.cpp matrice.cpp  && a.out

*/

int main () {
   // =========================================================================
   // 1. MANIPULATION DE MATRICES PLEINES 5x5 : B = F1 + F2
   // =========================================================================

   MatFull F1(5, 5);
   Matrice *pF1 = &F1;
   pF1->init(sqrt(3));
   cout << "F1 (5x5)" <<endl;
   pF1->affiche();

   MatFull F2(5, 5);
   F2.init(1.0);
   cout << "F2 (5x5)"<<endl;
   F2.affiche();

   // B = F1 + F2 (Matrice Full 5x5)
   MatFull B;
   B = F1 + F2;
   cout << "B = F1 + F2" << endl;
   B.affiche();

   // =========================================================================
   // 2. MANIPULATION DE MATRICES SYMÉTRIQUES 5x5 : A = S1 + S2
   // =========================================================================

   MatSym S1(5);
   S1.init(sqrt(2));
   cout << "S1 (5x5)" << endl;
   S1.affiche();

   MatSym S2(5);
   S2.init(2.0);
   cout << "S2 (5x5)"<<endl;
   S2.affiche();

   // A = S1 + S2 (Matrice Symétrique 5x5)
   MatSym A;
   A = S1 + S2;
   cout << "A = S1 + S2"<<endl;
   A.affiche();

}
