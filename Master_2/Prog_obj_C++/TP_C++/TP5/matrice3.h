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
        virtual void affiche() const;
        virtual void init(double);
        ~Matrice();
        virtual Matrice& operator=(const Matrice&);
        double*& operator[](int);
        double& operator()(int,int);
};

class MatFull:public Matrice{
    public:
        MatFull();
        MatFull(int,int);
        MatFull(const MatFull&);
        MatFull operator+(const MatFull&);
};

class MatSym:public Matrice{
    public:
        MatSym();
        MatSym(int);
        MatSym(const MatSym&);
        void affiche() const;
        void init(double);
        MatSym operator+(const MatSym&);
};

#endif