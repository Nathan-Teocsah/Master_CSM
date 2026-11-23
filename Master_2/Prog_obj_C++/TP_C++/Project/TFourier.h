#ifndef H_TFOURIER
#define H_TFOURIER

#include <vector>

class Complexe_error{
    private :
        int cas=0;
    public :
        const char* what() const;
};

class Complexe{
    private:
        double re,im;
    public:
        Complexe();
        Complexe(const double,const double i=0);
        Complexe(const Complexe&);

        double real() const;
        double imag() const;
        void affiche() const;

        Complexe conjugate() const;
        Complexe exp() const;

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


class FTVector:public std::vector<Complexe>{
    private:
        vector<Complexe> Poly;
    public:
        

};


#endif