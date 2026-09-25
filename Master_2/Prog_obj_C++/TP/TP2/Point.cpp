#include "header.hpp"
#include <iostream>

using namespace std;

Point::Point(float x=1,float y=2);xP(x),yP(y){
    cout<<"Création de point "<<this<<endl ;
}

Point::Point(float* P){
    P = new float[2];
    xP = P[0];
    yP = P[1];

}
void Point::affiche(){
    cout<<"x=\t"<<xP<<", \t y=\t"<<yP<<endl;
}