#ifndef HEADER_H
#define HEADER_H
    #include <iostream>

    int prod(int,int);
    double prod(double,double);
    float carreV(float);
    void carreP(float*);
    void carreR(float&);

    class Point{
        public:
            Point(float,float);
            void affiche();
            ~ Point(){ std::cout << " destruction d ' un point : " << this << std::endl ;}
        private:
            float xP,yP;
    };
#endif