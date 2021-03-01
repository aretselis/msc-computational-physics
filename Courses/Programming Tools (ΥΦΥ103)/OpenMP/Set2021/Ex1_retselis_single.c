#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define pi M_PI
#define N 200

int main(){
	// Variable declaration
	double a_square = 2/(pi*pi);
	double x_start = 0;
	double x_end = 12;
	double t_start = 0;
	double t_end = 5*pi;
	double dx = (x_end-x_start)/(N-1);
	double dt = dx/(2*sqrt(a_square));
	double c = sqrt(a_square)*dt/dx;
	int M = (t_end-t_start)/dt + 1;
	int i,n;
	//double u_xt[N][M];
	double **u_xt;
	u_xt = (double**)malloc(N*sizeof(double*));
	for(i=0;i<N;i++){
		u_xt[i] = (double*)malloc(M*sizeof(double));
	}
	// Initial & boundary conditions
	
	for(i=0; i<N; i++){
		if(i==0 || i==N-1 || i*dx<2 || i*dx>4){
			u_xt[i][0] = 0;
		}
		else{
			u_xt[i][0] = sin(pi*i*dx);
		}
	}
	
	// Lax-Wendroff method
	
	for(n=1; n<M; n++){
		for(i=0; i<N; i++){
			if(i==0 || i ==N-1){
				u_xt[i][n] = 0;
			}
			else{
				u_xt[i][n] = u_xt[i][n-1] - c*(u_xt[i+1][n-1]-u_xt[i-1][n-1])/2 + pow(c,2)*(u_xt[i+1][n-1]-2*u_xt[i][n-1]+u_xt[i-1][n-1])/2;
			}
		}
	}
	
	// Write results in file (csv format)
	
	FILE *fp;
	fp = fopen("results.csv", "w+");
	for(n=0; n<M; n++){
		for(i=0; i<N; i++){
			if(i==N-1){
				fprintf(fp,"%lf\n",u_xt[i][n]);
			}
			else{
				fprintf(fp,"%lf,",u_xt[i][n]);
			}
		}
	}
	fclose(fp);
	for (i = 0; i < N; i++){  
   		free(u_xt[i]);  
	}  
	free(u_xt);
	return 0;
}
