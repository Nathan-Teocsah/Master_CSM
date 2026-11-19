#ifndef H_MATRICE3
#define H_MATRICE3

#include <vector>

class Vec:public std::vector<double>{
    public :
        Vec(const int);
        void init(const double);
        void affiche() const;
        Vec operator+(const Vec&) const;
};

class Mat_err{
    private:
        int cas; // =0 ligne neg; =1 col neg; =2 les deux
    public:
        Mat_err(const int cas):cas(cas){};
        const char* what() const;
};

class Matrice{
    protected:
        int nbl;
        int nbc;
        double** val;
    public:
        Matrice();
        Matrice(const int,const int);
        Matrice(const Matrice&);
        virtual void affiche() const;
        virtual void init(const double);
        ~Matrice();
        virtual Matrice& operator=(const Matrice&);
        double*& operator[](const int);
        double& operator()(const int,const int);
};

class MatFull:public Matrice{
    public:
        MatFull();
        MatFull(const int,const int);
        MatFull(const MatFull&);
        MatFull operator+(const MatFull&);
};

class MatSym:public Matrice{
    public:
        MatSym();
        MatSym(const int);
        MatSym(const MatSym&);
        void affiche() const;
        void init(const double);
        MatSym operator+(const MatSym&);
};

#endif