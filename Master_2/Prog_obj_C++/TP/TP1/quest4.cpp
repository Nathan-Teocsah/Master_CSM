#include <iostream>
#include "point.h"

using namespace std;
int main(){
  Point P(2,3);
  P.affiche();
  Point Q;
  Q.affiche();
  Point::affichePointRef();
  Point::modPointRef();
  Point::affichePointRef();
  double v[2] = {2,3};
  P.translate(v);
  P.affiche();
}
