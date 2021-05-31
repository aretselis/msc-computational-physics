#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define threads_number 4


int main(){
	int i;
	double array[10];
	int size=10;
	for (i=0; i<size; i++) {
		array[i] = 0;
	}
	#pragma omp parallel num_threads(threads_number) shared(array) default(none)
	{
	int id = omp_get_thread_num();
	int n = omp_get_num_threads();
	array[id] = id*n;
	}
	
	for (i=0; i<size; i++) {
		printf("array[%d] = %d\n", i, array[i]);
	}
	return 0;
}
