#ifndef H_VECT1
#define H_VECT1

class Vect{
    private:
        int lg;
        double* val;
    public:
        Vect(int);
        void init(double);
        void affiche();
        double& operator [](int i){return val[i];};
};

#endif