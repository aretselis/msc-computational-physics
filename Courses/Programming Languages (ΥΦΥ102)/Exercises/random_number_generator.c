#include <stdio.h>
#include <stdlib.h>
#include <time.h>

float float_generator(float min, float max){
	/* Check and re-arrange numbers if needed*/
	float temp;
	if (min > max){
			temp = max;
			max = min;
			min = temp;
	}
	return min + (float) (rand())/((float) (RAND_MAX/(max-min)));
}

int main()
{
   int i, n;
   time_t t;
   float upper_lim=9, lower_lim=5.5, result;
   srand((unsigned) time(&t));
   
   n = 100;
   
   /* Intializes random number generator */
   srand((unsigned) time(&t));

   /* Print 5 random numbers from 0 to 49 */
   for( i = 0 ; i < n ; i++ ) 
   {
      result = float_generator(lower_lim, upper_lim);
      printf("%.4f\n", result);
   }
   
   return(0);
}
