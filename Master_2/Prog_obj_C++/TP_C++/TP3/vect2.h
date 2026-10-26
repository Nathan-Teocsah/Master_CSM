#ifndef H_VECT2
#define H_VECT2

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
        //friend int getlg(const Vect& );
        int getlg();
};

#endif