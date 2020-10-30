#include <stdio.h>
#include <math.h>

double f(double x);

int main(){
	double xl, xu, xr, es,value=1, value_prev=0;
	int n;
	
	printf("Enter upper value: ");
	scanf("%lf", &xu);
	printf("Enter lower value: ");
	scanf("%lf", &xl);
	xr=(xl+xu)/2;
	printf("Enter the number of significant digits to be computed (Scarborough criterion): ");
	scanf("%d", &n);
	es=(0.5*pow(10,(2-n)));
	
	while(1){
		if(f(xl)*f(xr)<0){
			xu=xr;
		}
		else if(f(xl)*f(xr)>0){
			xl=xr;
		}
		else if(f(xl)*f(xr)==0){
			break;
		}
		xr=(xl+xu)/2;
		printf("\nxr equals %lf", xr);
	}
	printf("\nThe root in given interval is equal to %lf", xr);
	
	return 0;
}

double f(double x){
	return ((9.8*69.1*(1-exp(-x*10/68.1))/x)-40);
}
