#include <iostream>
using namespace std;

void exchange(int &a,int &b){
	int temp = a;
	a = b;
	b = temp;
	return;
}

int main(){
	
	int x = 5;
	int y = 3;
	exchange(x,y);
	cout << "X="<<x<<"\nY="<<y;
	
	return 0;
}
