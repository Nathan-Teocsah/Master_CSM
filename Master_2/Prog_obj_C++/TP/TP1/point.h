#ifndef POINT_H
#define POINT_H
class  Point{
private:
  double xP,yP;
  static Point PointRef;
public:
  Point();
  Point(double xP,double yP);
  void affiche();
  double montre_x();
  double montre_y();
  void modif(double,double);
  static void affichePointRef();
  static void modPointRef();
  void translate(double v[2]);
};
#endif
