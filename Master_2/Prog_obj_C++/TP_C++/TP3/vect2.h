#ifndef H_VECT1
#define H_VECT1

class Vect{
    private:
        int lg;
        double* val;
    public:
        Vect(int n = 0);
        void init(double);
        void affiche();
        double& operator [](int i){return val[i];};
        Vect(const Vect&);
        Vect& operator =(const Vect& );
};

#endif