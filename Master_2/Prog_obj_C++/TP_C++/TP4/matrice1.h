#ifndef H_MATRICE1
#define H_MATRICE1

class Matrice{
    private:
        int nbl;
        int nbc;
        double** val;
    public:
        Matrice(int,int);
        void affiche();
        void init(double);
        Matrice operator+(Matrice&);

};

#endif