#include <stdio.h>

int main(){
	
	/* Variable Declaration */
		
	int hours,minutes,hours_deg,minutes_deg,result;
	
	/* User input */
	
	do{
	printf("\nEnter time in HH:MM format (24 hours): ");
	scanf("%d:%d", &hours, &minutes);
	}while(hours>23 || hours<0 || minutes>59 || minutes <0);

	/*Time conditioning*/
	
	if(hours>12){
		hours = hours - 12; 
	}
	if(hours==12){
		hours = 0;
	}
	hours_deg = hours * 30;
	minutes_deg = minutes * 6;
	
	/* Compute & display result*/
	
	if(minutes_deg>=hours_deg){
		result = minutes_deg - hours_deg;
		printf("The angle between hours and minutes indicator is %d degrees.", result);
	}
	else{
		hours_deg = (360-hours_deg);
		result = hours_deg + minutes_deg;
		printf("The angle between hours and minutes indicator is %d degrees", result);
	}
	
	return 0;
}
