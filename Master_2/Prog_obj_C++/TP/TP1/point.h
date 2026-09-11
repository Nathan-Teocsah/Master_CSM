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
  void affichePointRef()
};
#endif
