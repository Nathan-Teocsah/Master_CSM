#include "matrice3.h"
#include <iostream>
#include <fstream>

using namespace std;
int main(){
    Vec v(5);
    v.init(2.3);
    Vec w(3);
    w.init(0.7);
    (v+w).affiche();
}