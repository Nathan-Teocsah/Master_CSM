#ifndef H_VECT3
#define H_VECT3

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
        Vect& operator =(const Vect);
        //friend int getlg(const Vect& );
        int getlg();
        ~Vect();
        Vect operator +(const Vect);
        void add(const Vect&, const Vect&);
};

template <class T1, class T2>
T1 prod(T1 A,T2 B);

#endif