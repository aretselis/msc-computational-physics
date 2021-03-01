#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define threads_number 4

double f(double x){
	return 4/(1+(x*x));
}

int main(){
	// Variable declaration
	int N = 10000001; // Must be odd
	int x_min = 0;
	int x_max = 1;
	double dx = (double) (x_max-x_min)/(N-1);
	double odd_sum=0, even_sum=0,I;
	int i;
	
	// Array allocation
	double **values;
	values = (double**)malloc(N*sizeof(double*));
	for(i=0;i<N;i++){
		values[i] = (double*)malloc(2*sizeof(double));
	}
	
	double start_time = omp_get_wtime(); 
	
	#pragma omp parallel num_threads(threads_number) shared(values,dx,x_max,x_min,N) private(i) reduction(+: odd_sum,even_sum)
	{
		// Identify thread ID and total threads
		int id = omp_get_thread_num();
		int nThreads = omp_get_num_threads();
		
		//Find start and end point for the loop
		
		int istart = id*N/nThreads;
		int iend = (id+1)*N/nThreads;
		if(id==nThreads-1){
			iend=N;
		} 	
		// Fill in array with values
		for(i=istart;i<iend;i++){
			values[i][0] = i*dx;
			values[i][1] = f(i*dx);
		}
		#pragma omp barrier
		if(id==0){
			istart=1;
		}
		if(id==nThreads-1){
			iend=N-1;
		}
		// Numerically integrate using simpson's rule		
		for(i=istart;i<iend;i++){
			if(i%2 != 0 && i<N-2){
				even_sum += values[i][1];
			}
			else{
				odd_sum += values[i][1];	
			}
		}
	}
	I = (x_max-x_min)*(values[0][1]+4*odd_sum+2*even_sum+values[N-1][1])/(3*(N));
	printf("Value of pi = %lf\n", I);
		
	
	double end_time = omp_get_wtime();
    printf("Time: %f seconds", end_time - start_time);
		
	// Free-up memory
	for (i = 0; i < N; i++){  
   		free(values[i]);  
	}  
	free(values);
	return 0;
}
