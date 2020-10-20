#include <stdio.h>

int main(){
	double a,b,c,min,mid,max,dif_min,dif_max;
	
	/* User input */
	
	printf("Enter first number:");
	scanf("%lf", &a);
	printf("Enter second number:");
	scanf("%lf", &b);
	printf("Enter third number:");
	scanf("%lf", &c);
	
	/* Sort numbers */ 
	
	if(a>b && a>c){
		max=a;
		if(b>c){
			mid=b;
			min=c;
		}
		else{
			mid=c;
			min=b;
		}
	}
	
	if(b>a && b>c){
		max=b;
		if(a>c){
			mid=a;
			min=c;
		}
		else{
			mid=c;
			min=a;
		}
	}
	
	if(c>a && c>b){
		max=c;
		if(a>b){
			mid=a;
			min=b;
		}
		else{
			mid=b;
			min=a;
		}
	}
	
	/* Calculate differences and print true if correct */
	
	dif_min = mid - min;
	dif_max = max - mid;
	
	if(dif_min==dif_max){
		printf("\nTRUE");
	}
	
	return 0;
}
