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
        vector<Complexe> poly;
        Complexe (**f)(double); //fonction sur laquelle on va appliquer la transformée de fourier
    public:
        FTVector(); // Vecteur vide
        FTVector(Complexe (**)(double)); //Affectation à une fonction pour effectuer la transformée de fourier
        FTVector(const vector<Complexe>&); //Vecteur sur lequel appliquer la transformée de fourier (inverse ou non)
        FTVector(const FTVector&);  //par copie
        
        void FourierDiscrete(int n=0);
        void FourierInverse();
};


#endif