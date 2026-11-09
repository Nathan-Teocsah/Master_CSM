#ifndef H_MATRICE3
#define H_MATRICE3

class Matrice{
    protected:
        int nbl;
        int nbc;
        double** val;
    public:
        Matrice();
        Matrice(int,int);
        Matrice(Matrice&);
        void affiche() const;
        void init(double);
        virtual Matrice operator+(const Matrice&);
        ~Matrice();
        virtual Matrice& operator=(const Matrice&);
};

class MatFull:public Matrice{
    public:
        MatFull();
        MatFull(int,int);
        MatFull(MatFull&);
        ~MatFull();
        /*
        MatFull& operator=(const MatFull&);
        MatFull operator+(const MatFull&);
        */
};

#endif