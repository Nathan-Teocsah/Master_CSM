#ifndef POINT_H
#define POINT_H
#include <iostream>
class  Point{
private:
  double xP,yP;
  static Point PointRef;
public:
  Point();
  Point(double,double);
  void affiche();
  double montre_x();
  double montre_y();
  void modif(double,double);
  static void affichePointRef();
  static void modPointRef();
  void translate(double v[2]);
  bool ok();
  double distance();
};

class Bipoint{
  private :
    Point P;
    Point Q;
  public:
    Bipoint(Point A, Point B):P(A),Q(B){
      std::cout << "construction Point,Point "<< std::endl;
      std::cout << "Objet " << this << std::endl;
    };
};
#endif
