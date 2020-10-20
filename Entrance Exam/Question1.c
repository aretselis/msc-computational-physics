# include <stdio.h>

int main(){
	int a,b,c,sum;
	
	/* User input */
	
	printf("Enter first number:");
	scanf("%d", &a);
	printf("Enter second number:");
	scanf("%d", &b);
	printf("Enter third number:");
	scanf("%d", &c);
	
	/* Check for the rules */
	
	if(a>=90 && a<=100){
		if(a!=91 && a!=97){
			a=0;
		}
	}	
	if(b>=90 && b<=100){
		if(b!=91 && b!=97){
			b=0;
		}
	}	
	if(c>=90 && c<=100){
		if(c!=91 && c!=97){
			c=0;
		}
	}
	
	/* Compute and print sum */
	
	sum = a+b+c;
	printf("Result based on the rules is equal to %d", sum);
		
	return 0;
}
