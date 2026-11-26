#ifndef H_OISEAU
#define H_OISEAU

 #include <iostream>

class Oiseau{
    private:
        std::string espece;
        std::string moObs;
        int joObs;
        int numOiseau;
        float envergure;
    public:
        Oiseau(std::string sonEspece, std::string moisOb="inconnu",
                int jourOb=0, int numAttrib=0, float enve=0);
        
                void afficheEspece() const;
                void afficheNum() const;
                void afficheEnvergure() const;
                virtual void affiche() const;

};


#endif