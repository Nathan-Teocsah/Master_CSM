#ifndef H_MATRICE2
#define H_MATRICE2

class Matrice{
    private:
        int nbl;
        int nbc;
        double** val;
    public:
        Matrice();
        Matrice(int,int);
        Matrice(Matrice&);
        void affiche();
        void init(double);
        Matrice operator+(const Matrice&);
        ~Matrice();
        Matrice& operator=(const Matrice&);
};

#endif