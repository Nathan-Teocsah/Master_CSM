#ifndef H_TFOURIER
#define H_TFOURIER

#include <vector>

class Complexe{
    private:
        double re,im;
    public:
        Complexe();
        Complexe(const double,const double);
        Complexe(const Complexe&);
        double real() const;
        double imag() const;
        Complexe conjugate() const;
        Complexe operator+(const Complexe&) const;
        Complexe operator-(const Complexe&) const;
        Complexe operator*(const Complexe&) const;
        Complexe operator/(const Complexe&) const;
        Complexe operator+=(const Complexe&);
        Complexe operator-=(const Complexe&);
        Complexe operator*=(const Complexe&);
        Complexe operator/=(const Complexe&);
        bool operator==(const Complexe&) const;
        bool operator!=(const Complexe&) const;
};

/*
class FTVector:public std::vector<double>{

}
*/

#endif