#include "matrice3.h"

int main(){
    MatFull A(2,3);
    MatFull B(2,3);

    Matrice D(2,3);
    
    MatFull C(2,3);

    MatSym E(3);
    E.init(2);
    E.affiche();
}