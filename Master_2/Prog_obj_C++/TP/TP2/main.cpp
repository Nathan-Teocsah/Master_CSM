#include <iostream>
#include "header.hpp"
using namespace std;
int main(){
    int a = 2, b=3;
    double x=2.1,y=3.5;
    cout<<"carreV : "<<carreV(x)<< endl;
    float X=2.5;
    carreP(&X);
    cout<<"carreP : "<<X<<endl;
    float& X_ref(X);
    carreR(X);
    cout<<"carreR : "<<X<<endl;
    carreR(X_ref);
    cout<<"carreR : "<<X<<endl;
    Cltest P;
}