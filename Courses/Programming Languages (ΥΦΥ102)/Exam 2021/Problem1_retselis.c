#include <stdio.h>
#define elements 12 /* Number of elements in A array */

int solution(int A[], int N){
	int counter, hills=0, valleys=0, result=0, start, end, p, q;
	
	/* Start border case*/
	for(counter=0;counter<N;counter++){
			if(A[counter]==A[counter+1]){
				continue;
			}
			else{
				start = counter+1; /* The next step is the first step for the main loop */
				result = result +1;
				
				break;
			}
	}	
	
	/* End border case*/
	for(counter=N;counter>0;counter--){
		if(A[counter]==A[counter-1]){
			continue;
		}
		else{
			end = counter-1; /* The next previous is the last step for the main loop */
			result = result +1;
			break;
		}		
	}
	
	/* Check if only one castle can be built */
	if(start>end){
		result = result-1;
	}	
	p=0;
	
	/* Main searching loop*/
	for(counter=start;counter<end;counter++){
		if(A[counter]==A[counter+1]){
			if(p==0){
				p = counter;
			}
			continue; /* continue until you find PQ inteval*/
		}
		else{
			if(p==0){
				p = counter;
			}
			q = counter;
			/*Check if hill*/
			if(A[p-1]<A[p] && A[q+1]<A[q]){
				hills = hills +1;
				/*printf("\n Found hill! %d,%d  ", p,q);*/
			}
			/*Check if valley*/
			else if(A[p-1]>A[p] && A[q+1]>A[q]){
				valleys = valleys +1;
				/*printf("\nFound valley! %d,%d  ", p,q);*/
			}
			/* else move on to next step */
			p = 0;
		}
		
	}
	
	result = result + hills + valleys;
	
	return result;
}

int main(){
	/* Always change elements above when changing the array A*/
	
	int A[elements]={2,2,3,4,3,3,2,2,1,1,2,5};
	/*int A[elements]={-3,-3};*/ 
	int i, solved;
	
	printf("Array A elements are:\t ");  
    for(i=0; i<elements; i++)  
    {  
        printf("%d  ", A[i]);
	}
	
	solved = solution(A,elements);
	printf("\n\nTotal castles that can be built: %d  ", solved);
	
	return 0;
}
