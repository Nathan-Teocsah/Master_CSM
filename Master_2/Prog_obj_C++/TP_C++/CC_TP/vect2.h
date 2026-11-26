#ifndef H_VECT2
#define H_VECT2

class Vect{
    private:
        int lg;
        double* val;
    public:
        Vect(int n = 0);
        void init(double);
        void affiche() const;
        Vect(const Vect&);
        Vect& operator =(const Vect& );
        Vect operator -(const Vect& ) const;
        int getlg();
        void modif(int,double);
};

#endif