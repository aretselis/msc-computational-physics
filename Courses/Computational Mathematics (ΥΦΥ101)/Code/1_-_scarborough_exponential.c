# include <stdio.h>
# include <math.h>

int main(){
	double es, ea, value=1, value_prev=0, temp=1, x;
	int i,n;
	
	/* Input e^x and compute scarborough criterion */
	
	printf("Enter the value of x to compute e^x: ");
	scanf("%lf", &x);
	printf("Enter the number of significant digits to be computed (Scarborough criterion): ");
	scanf("%d", &n);
	es=(0.5*pow(10,(2-n)));
	printf("Scarborough criterion es=%lf %%\n\n", es);
	
	/* Iterative Taylor series (a=0) to calculate  e^x */
	
	for(i=1;i;i++){
		temp=temp*x/i;
		value=value+temp;
		ea=fabs((value-value_prev)/value)*100;
		printf("Value of e^%lf is %lf with ea being %lf\n", x, value, ea);
		if(ea<es){ /* if approximation error ea below es stop computing */
			break;
		}
		value_prev=value;
	}
	printf("\nFinal value of e^%lf is %lf with ea being %lf %% (below es=%lf %%)", x, value, ea, es);
	
	return 0;
}
