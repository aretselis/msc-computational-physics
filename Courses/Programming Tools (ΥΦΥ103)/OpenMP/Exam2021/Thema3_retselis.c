#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define threads_number 4

double f(double x){
	// Function to be integrated
	return 4/(1+(x*x));
}

int main(){
	// Variable declaration
	// Integration using Simpson's rule
	int N = 10000001; // Must be odd
	if(N%2==0){
		printf("Number of points must be odd! Exiting...\n");
		return 0;
	}
	int x_min = 0;
	int x_max = 1;
	double dx = (double) (x_max-x_min)/(N-1);
	double odd_sum=0, even_sum=0,I;
	int i;
		
	double start_time = omp_get_wtime(); 
	
	#pragma omp parallel num_threads(threads_number) shared(dx,x_max,x_min,N) private(i) reduction(+: odd_sum,even_sum)
	{
		// Identify thread ID and total threads
		int id = omp_get_thread_num();
		int nThreads = omp_get_num_threads();
		
		//Find start and end point for the loop
		int istart = id*N/nThreads;
		int iend = (id+1)*N/nThreads;
		
		// Get rid of border cases
		if(id==0){ // Remove f(0) from loop
			istart=1;
		}
		if(id==nThreads-1){
			iend=N-1; // Remove f(1) from loop (stop at N-1)
		}
		
		// Numerically integrate using simpson's rule (calculate sums)		
		for(i=istart;i<iend;i++){
			if(i%2 == 0 && i<N-2){ // Even sum has to stop at N-2
				even_sum += f(i*dx);
			}
			else{
				odd_sum += f(i*dx);	
			}
		}
	}
	double end_time = omp_get_wtime();
	
	// Compute integral and print pi value
	I = (x_max-x_min)*(f(x_min)+4*odd_sum+2*even_sum+f(x_max))/(3*(N-1));
	printf("Value of pi = %lf\n", I);
	
	// Print time taken	
    printf("Time: %f seconds", end_time - start_time);
    
	return 0;
}
