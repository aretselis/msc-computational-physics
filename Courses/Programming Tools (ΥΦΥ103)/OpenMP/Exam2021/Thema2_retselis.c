#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <omp.h>

#define threads_number 4

// With automatic worksharing
double test1 (double *a, double *rhs, double h, int size)
{
	int i;
	double temp, sum;
	sum = 0;
	// Enter parallel region
	#pragma omp parallel num_threads(threads_number) private(temp) shared(a,rhs,h) reduction(+:sum)
	{
	// automatic worksharing of the loop
	#pragma omp for	schedule(static)
	for (i=1; i<size-1; i++) {
		temp = (a[i-1] - 2*a[i] + a[i+1] + h*h*rhs[i]);
		sum += sqrt(temp*temp);
	}
	}	
	return sum;
}

// With manual worksharing
double test2 (double *a, double *rhs, double h, int size)
{
	int i;
	double temp, sum;
	sum = 0;
	// Enter parallel region
	#pragma omp parallel num_threads(threads_number) private(temp,i) shared(a,rhs,h) reduction(+:sum)
	{
	// Get thread ID and number of threads
	int id = omp_get_thread_num();
	int nThreads = omp_get_num_threads();
		
	//Find start and end point for the loop
	int istart = (id*size/nThreads);
	int iend = ((id+1)*size/nThreads);
	
	//Set border cases
	if(istart==0){
		istart=1;
	}
	if(id==nThreads-1){
		iend=size-1;
	}
	for (i=istart; i<iend; i++) {
		temp = (a[i-1] - 2*a[i] + a[i+1] + h*h*rhs[i]);
		sum += sqrt(temp*temp);
	}
	}	
	return sum;
}
