#include <iostream>
#include <cmath>
#include "matrice4.h"
#include "vect2.h"
using namespace std;

Vect MatVect(const Matrice& A,Vect v1){
   // . Cette fonction requiert quelques fonctions membres
   // dans les classes Vect et Matrice.
   // . La programmation des fonctions getVal et getnbc
   // pour une matrice depend du type de celle-ci :
   // MatFull ou MatSym.
   Vect Av1(A.getnbl());
   Av1.init(0);
   for (int i=0;i<A.getnbl();i++){
      for (int j=0;j<A.getnbc();j++){
         Av1.modif(i,Av1.getVal(i)+A.getVal(i,j)*v1.getVal(j));
      }
   }
   return Av1;
}

int main () {
   // =========================================================================
   // 1. MANIPULATION DE MATRICES PLEINES 5x5 : B = F1 + F2
   // =========================================================================

   MatFull F1(5, 5);
   Matrice *pF1 = &F1;
   pF1->init(sqrt(3));

   MatFull F2(5, 5);
   F2.init(1.0);
   F2.modif(1,0,2);
   F2.modif(2,0,3);
   F2.modif(3,0,4);
   F2.modif(4,0,5);

   // B = F1 + F2 (Matrice Full 5x5)
   MatFull B;
   B = F1 + F2;

   // =========================================================================
   // 2. MANIPULATION DE MATRICES SYMÉTRIQUES 5x5 : A = S1 + S2
   // =========================================================================

   MatSym S1(5);
   S1.init(sqrt(2));

   MatSym S2(5);
   S2.init(2.0);
   S2.modif(1,0,3);
   S2.modif(2,0,4);
   S2.modif(3,0,5);
   S2.modif(4,0,6);

   // A = S1 + S2 (Matrice Symétrique 5x5)
   MatSym A;
   A = S1 + S2;

   // =========================================================================
   // 3. CALCUL DU PRODUIT MATRICE * VECTEUR v1 (5x1)
   // =========================================================================

   cout << endl << "========================================" << endl;
   cout << " CALCUL D'UN PRODUITS MATRICE * VECTEUR " << endl;
   cout << "========================================" << endl;

   // Instanciation du vecteur v1 (5x1) avec les composantes souhaitees
   Vect v1(5);
   v1.modif(0,sqrt(3.0));
   v1.modif(1, 4.0);
   v1.modif(2, 0.45);
   v1.modif(3, 0.66);
   v1.modif(4, sqrt(2.0));
   v1.affiche("Vecteur v1 (5x1)");

   // --- CALCUL Bv1 = B * v1 (Matrice Pleine 5x5 * Vecteur 5x1) ---

   Vect Bv1 = MatVect(B,v1);
   B.affiche("B");
   Bv1.affiche("Bv1 = B * v1");

   // --- CALCUL x2 = A * v1 (Matrice Symétrique 5x5 * Vecteur 5x1) ---

   Vect Av1 = MatVect(A,v1);
   A.affiche("A");
   Av1.affiche("Av1 = A * v1");

   return 0;
}
