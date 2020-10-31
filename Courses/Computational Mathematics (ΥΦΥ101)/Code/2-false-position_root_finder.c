#include <stdio.h>
#include <math.h>

double f(double x);

int main(){
	double xl, xu, xr, es, ea, value=1, value_prev=0;
	int n;
	
	printf("Enter upper value: ");
	scanf("%lf", &xu);
	printf("Enter lower value: ");
	scanf("%lf", &xl);
	xr=xu-((f(xu)*(xl-xu))/(f(xl)-f(xu)));
	/* printf("xr equals to %lf\n", xr);*/
	printf("Enter the number of significant digits to be computed (Scarborough criterion): ");
	scanf("%d", &n);
	es=(0.5*pow(10,(2-n)));
	printf("Scarborough criterion es=%lf %%\n\n", es);
	
	while(1){
		if(f(xl)*f(xr)<0){
			xu=xr;
			value=xr;
		}
		else if(f(xl)*f(xr)>0){
			xl=xr;
			value=xr;
		}
		/* Use scarborough as stopping condition */
		ea=fabs((value-value_prev)*100/value);
		/* printf("Current ea equals %lf", ea); */
		if(ea<es){ /* if approximation error ea below es stop computing */
			break;
		} 
		value_prev=xr;
		xr=xu-((f(xu)*(xl-xu))/(f(xl)-f(xu)));
		/* printf("\nxr equals %lf\n", xr); */
	}
	printf("\n\nThe root in given interval is equal to %lf", xr);
	
	return 0;
}

double f(double x){
	return ((9.8*68.1*(1-exp(-x*10/68.1))/x)-40);
}

