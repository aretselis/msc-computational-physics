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

void mergesort(int arr[],int low, int middle, int high){
	int n1 = middle-low+1;
	int n2 = high-middle;
	int temp_array_one[n1];
	int temp_array_two[n2];
	int i,j,k;
	
	/* Split into two sub-arrays*/
	
	for(i=0;i<n1;i++){
		temp_array_one[i] = arr[low+i]; 
	}
	for(i=0;i<n2;i++){
		temp_array_two[i] = arr[middle+1+i]; 
	}
	
	i=0;
	j=0;
	k=low;
	while(i<middle-low+1 && j<high-middle){
		if(temp_array_one[i]<=temp_array_two[j]){
			arr[k] = temp_array_one[i];
			i++;
		}
		else{
			arr[k] = temp_array_two[j];
			j++;
		}
		k++;
	}
	
	while (i < middle-low+1) {
        arr[k] = temp_array_one[i];
        i++;
        k++;
    }
    
    while (j < high-middle) {
        arr[k] = temp_array_two[j];
        j++;
        k++;
    }
}

void sort(int array[], int min, int max){
	if(min<max){
		int mid = min + (max-min)/2;
		sort(array,min,mid);
		sort(array,mid+1,max);
		mergesort(array,min,mid,max);
	}
	return;
}

int main(){
	
	int* numbers = ivector(1,elements);
	int i,j,min,temp;
	time_t t;
	srand((unsigned) time(&t));
	for (i=1;i<=elements;i++){
		numbers[i] = (rand() % (101) + 0);
	}
	printf("Merge Sort Demonstrator:\n\n");
	printf("Unsorted elements are:\t ");  
    for(i=1; i<=20; i++)  
    {  
        printf("%d  ", numbers[i]);
	}
	
	/* Begin Merge Sort */
	sort(numbers,1,elements);
	
	printf("\n\nSorted elements are:\t ");  
	
    for(i=1; i<=elements; i++)  
    {  
        printf("%d  ", numbers[i]);
	}
	
	return 0;
}

