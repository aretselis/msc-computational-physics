#include <stdio.h>

int main(){
	int n, base=1, result=0, k=0, m=0;
	
	printf("Enter integer n to find number of 1s appearing from zero until n: ");
	scanf("%d", &n);
	
	while(n>0){
		k = n % 10;
		n = n / 10;
		
		if(k>1){
			result = result + ((n+1)*base);
		} 
		else if(k<1){
			result = result + (n*base);
		}
		else{
			result = result + (n*base+m+1);
		}
		m = m + (k*base);
		base = base * 10;
	}
	
	printf("\nTotal number of 1s appearing from zero until %d is %d", n,result);
	
	return 0;
}