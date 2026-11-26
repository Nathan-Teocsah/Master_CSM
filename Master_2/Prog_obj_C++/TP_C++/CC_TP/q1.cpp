#include <iostream>
using namespace std;

float cubeV(float x) {return x*x*x;}
void cubeP(float *x) {*x = *x**x**x;}
void cubeR(float& x) {x = x*x*x;}

int main()
{
	float a=3.; 
	float b=2.5;
	float c=1.5;
	float d=b+c;
	cout << cubeV(a) << endl;
	cubeP(&a); 
	cubeR(a); 
	cout << "a = " << a << ", b = " << b << ", c = " << c << ", d = " << d << endl;
	cubeR(d);   
    cout << d << endl;
	cubeP(&d); 
	cout << "a = " << a << ", b = " << b << ", c = " << c << ", d = " << d << endl;
	cubeP(&c);
	cout << "a = " << a << ", b = " << b << ", c = " << c << ", d = " << d << endl;
	cout << cubeV(d) << endl;
	


}