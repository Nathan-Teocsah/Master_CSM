#include <iostream>
#include "oiseau.h"
using namespace std;

/*========== CLASSE GENERIQUE : OISEAU ===========*/

Oiseau::Oiseau(string sonEspece, string moisOs,
               int jourOb, int numAttrib, float enve)
               :espece(sonEspece),moObs(moisOs),
                joObs(jourOb), numOiseau(numAttrib),
                envergure(enve){}

void Oiseau::afficheEspece() const{
    cout<<"Espece : "<<espece<<endl;}
void Oiseau::afficheNum() const {
    cout<<"Numéro de l'oiseau : "<<numOiseau<<endl;}
void Oiseau::afficheEnvergure() const {
    cout<<"Envergure : "<<envergure<<endl;}
void Oiseau::affiche() const{
    cout<<"Informations sur l'oiseau :" << endl;
    (*this).afficheEspece();
    (*this).afficheNum();
    (*this).afficheEnvergure();
    cout<<"=================="<<endl;
}
