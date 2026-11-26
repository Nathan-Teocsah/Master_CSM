#ifndef H_OBSJOUR
#define H_OBSJOUR

 #include <iostream>
 #include "oiseau.h"

class ObsJour:public Oiseau{
    private:
        int nbOiseaux;
        Oiseau** listOiseaux;
        static Oiseau oiseauVide;
    public:
        ObsJour(int);

        void modif(int, Oiseau*);
        
        void afficheNbOiseaux() const;
        void afficheOiseau(int) const;
        void affiche() const;
};

#endif