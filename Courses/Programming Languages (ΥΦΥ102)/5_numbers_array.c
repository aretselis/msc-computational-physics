# include <stdio.h>
# define NUMBS 5

int main(){
	int i, numbers=NUMBS;
	int num[NUMBS];
	int max,min;
	double avg;
	int sum=0;
	
	for(i=0;i<numbers;i++){
		printf("Enter number:");
		scanf("%d", &num[i]);
		if(i==0){
			max=num[i];
			min=num[i];
		}
		if(num[i]>max)
		{
			max = num[i];
		}
		if(num[i]<min)
		{
			min = num[i];
		}
		sum=sum+num[i];
	}	
	
	printf("Max is equal to %d", max);
	printf("\nMin is equal to %d", min);
	avg = (double) sum/numbers;
	printf("\nAverage values is %.2lf", avg);
	
	return 0;
}
