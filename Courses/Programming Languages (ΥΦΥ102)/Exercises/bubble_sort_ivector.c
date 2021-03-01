#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define elements 20
#include <math.h>
#define NR_END 1
#define FREE_ARG char*

void nrerror(error_text)
char error_text[];
/* standard error handler */
{
        void exit();

        fprintf(stderr,"run-time error...\n");
        fprintf(stderr,"%s\n",error_text);
        fprintf(stderr,"...now exiting to system...\n");
        exit(1);
return;
}

int *ivector(nl,nh)
long nh,nl;
/* allocate an int vector with subscript range v[nl..nh] */
{
        int *v;

        v=(int *)malloc((unsigned int) ((nh-nl+1+NR_END)*sizeof(int)));
        if (!v) nrerror("allocation failure in ivector()");
        return v-nl+NR_END;
}

int main(){
	int* numbers = ivector(1,elements);
	int i,j,temp;
	
	/* Generate random integers in an array with n=elements */
	
	time_t t;
	srand((unsigned) time(&t));
	for (i=1;i<=elements;i++){
		numbers[i] = (rand() % (101) + 0);
	}
	printf("Bubble Sort Demonstrator:\n\n");
	printf("Unsorted elements are:\t ");  
    for(i=1; i<=elements; i++)  
    {  
        printf("%d  ", numbers[i]);
	}
	
	/* Begin Bubble Sort */
	
	for(i=1;i<=elements;i++){
		for(j=1;j<=elements-i;j++){
			if (numbers[j] > numbers[j+1]){
				temp = numbers[j];
				numbers[j] = numbers[j+1];
				numbers[j+1] = temp;
			}
		}
	}
	
	printf("\n\nSorted elements are:\t ");  
	
    for(i=1; i<=elements; i++)  
    {  
        printf("%d  ", numbers[i]);
	}
	
	return 0;
}
