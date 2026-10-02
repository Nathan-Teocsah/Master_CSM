#include <iostream>
#include "point.h"
#include <cassert>
#include <cmath>

using namespace std;

Point::Point(){
  xP=0;
  yP=0;
}

Point Point::PointRef(1.,1.);

bool Point::ok(){
  if (xP>=0 && yP>=0) return true;
  return false;
}

Point::Point(double a,double b){
  xP=a;
  yP=b;
  assert(ok());
}

double Point::montre_x(){
return xP;
}

double Point::montre_y(){
return yP;
}

void Point::modif(double x, double y){
  xP = x;
  yP = y;
  assert(ok());
}

void Point::affiche(){
  cout<<"coordonnée x = " <<xP<<" coordonnée y = "<<yP<<endl;
}

void Point::affichePointRef(){
  cout << "PointRef = (" << PointRef.montre_x() << "," << PointRef.montre_y() << ")" << endl;
}

void Point::modPointRef(){
  double x,y;
  cout << "x_PointRef = ";
  cin >> x;
  cout << "y_PointRef = ";
  cin >> y;
  PointRef.modif(x,y);
}

void Point::translate(double v[2]){
  xP += v[0];
  xP += v[1];
  assert(ok());
}

double Point::distance(){
  return sqrt(pow(PointRef.montre_x()-xP,2)+pow(PointRef.montre_y()-yP,2));
}



