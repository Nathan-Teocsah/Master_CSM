#include <iostream>
#include "ObsJour.h"
using namespace std;

Oiseau ObsJour::oiseauVide("inconnu");


/* 
Cette fonction n'est pas bien initialisé, je dois avoir
mal compris quelque chose dans la consigne, mais je ne vois
pas quoi.
*/
ObsJour::ObsJour(int nbOiseaux):nbOiseaux(nbOiseaux),listOiseaux(new Oiseau*[nbOiseaux]){
    for (int i=0; i<nbOiseaux; i++){
        listOiseaux[i] = &oiseauVide;
    }
}

void ObsJour::modif(int i, Oiseau* p_cetOiseau){
    listOiseaux[i-1] = p_cetOiseau;
}

void ObsJour::afficheNbOiseaux() const{
    cout << "Nombre d'oiseaux observés : "<<nbOiseaux<<endl;
}
void ObsJour::afficheOiseau(int i) const{
    cout << "Numéro du " << i<< "ième oiseau observé : " << endl;
    listOiseaux[i-1]->afficheNum();
}
void ObsJour::affiche() const{
    cout<<"Informations sur l'oiseau :" << endl;
    (*this).afficheNbOiseaux();
    (*this).afficheOiseau(2);
}


