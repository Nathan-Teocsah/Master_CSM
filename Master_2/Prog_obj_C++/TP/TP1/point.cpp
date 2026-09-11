#include <iostream>
#include "point.h"

using namespace std;

Point::Point(){
  xP=0;
  yP=0;
}

Point::Point(double a,double b){
  xP=a;
  yP=b;
}

void Point::affiche(){
  cout<<"coordonnée x = " <<xP<<" coordonnée y = "<<yP<<endl;
}

void Point::affichePointRef(){
  cout<<"PointRef = ("<<
}
