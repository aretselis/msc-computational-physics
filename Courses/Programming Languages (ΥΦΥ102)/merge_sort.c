#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define elements 20

int main(){
	
	int numbers[elements];
	int i,j,min,temp;
	
	/* Generate random integers in an array with n=elements */
	
	time_t t;
	srand((unsigned) time(&t));
	for (i=0;i<20;i++){
		numbers[i] = (rand() % (101) + 0);
	}
	printf("Merge Sort Demonstrator:\n\n");
	printf("Unsorted elements are:\t ");  
    for(i=0; i<20; i++)  
    {  
        printf("%d  ", numbers[i]);
	}
	
	/* Begin Selection Sort */
	
	
	printf("\n\nSorted elements are:\t ");  
	
    for(i=0; i<20; i++)  
    {  
        printf("%d  ", numbers[i]);
	}
	
	return 0;
}


