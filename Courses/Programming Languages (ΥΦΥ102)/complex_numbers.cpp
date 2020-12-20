#include <iostream>
using namespace std;

class Complex{
private:
	double real;
	double imag;
public:
	Complex(double x = 0.0, double y = 0.0){
		real = x;
		imag = y;
	}
	void print(){
		cout << real << " + "<< imag <<"i"<< endl;
	}
	friend Complex operator+(const Complex &a, const Complex &b);
};

Complex operator + (const Complex &a, const Complex &b){
	Complex result;
	result.real = a.real + b.real;
	result.imag =  a.imag + b.imag;
	return result;
};
/*
Complex operator-(Complex a, Complex b){
	Complex result(a.real-b.real,a.imag-b.imag);
	return result;
}

Complex operator*(Complex a, Complex b){
	Complex result((a.real*b.real-a.imag*b.imag),(a.real*b.imag+a.imag*b.real));
	return result;
}*/



int main(){
	
	Complex a(2,3);
	Complex b(1,5);
    Complex c = a + b;
    c.print();
	return 0;
}
