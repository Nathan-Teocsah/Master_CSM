#include "matrice3.h"

int main(){
    MatFull A(2,3);
    MatFull B(2,3);

    Matrice D(2,3);
    Matrice F(D);
    
    MatFull C(A+B);
}