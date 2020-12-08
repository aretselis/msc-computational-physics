#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define elements 20

int main(){
	
	int numbers[elements];
	int i,j,temp;
	
	/* Generate random integers in an array with n=elements */
	
	time_t t;
	srand((unsigned) time(&t));
	for (i=0;i<20;i++){
		numbers[i] = (rand() % (101) + 0);
	}
	
	printf("Unsorted elements are:\t ");  
    for(i=0; i<20; i++)  
    {  
        printf("%d  ", numbers[i]);
	}
	
	/* Begin Bubble Sort */
	
	for(i=0;i<elements-1;i++){
		for(j=0;j<elements-i-1;j++){
			if (numbers[j] > numbers[j+1]){
				temp = numbers[j];
				numbers[j] = numbers[j+1];
				numbers[j+1] = temp;
			}
		}
	}
	
	printf("\n\nSorted elements are:\t ");  
	
    for(i=0; i<20; i++)  
    {  
        printf("%d  ", numbers[i]);
	}
	
	return 0;
}
