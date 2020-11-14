#include <stdio.h>

int main(){
    
    int a,b,c,d,e;
    int min, max;
    double avg;
    
    printf("Enter first number:");
    scanf("%d", &a);
    printf("Enter second number:");
    scanf("%d", &b);
    printf("Enter third number:");
    scanf("%d", &c);
    printf("Enter fourth number:");
    scanf("%d", &d);
    printf("Enter fifth number:");
    scanf("%d", &e);
    
    /* Calculate max */ 
    
    if ((a>b) && (a>c) && (a>d) && (a>e))
    {    
        max=a;
    }
    else if ((b>a) && (b>c) && (b>d) && (b>e))
    {    
        max=b;
    }
    else if ((c>a) && (c>b) && (c>d) && (c>e))
    {    
        max=c;
    }
    else if ((d>a) && (d>c) && (d>b) && (d>e))
    {    
        max=d;
    }
    else 
    {
        max=e;
    }
    
printf("Max is equal to %d", max);

    /* Calculate min */ 
    
    if ((a<b) && (a<c) && (a<d) && (a<e))
    {    
        min=a;
    }
    else if ((b<a) && (b<c) && (b<d) && (b<e))
    {    
        min=b;
    }
    else if ((c<a) && (c<b) && (c<d) && (c<e))
    {    
        min=c;
    }
    else if ((d<a) && (d<c) && (d<b) && (d<e))
    {    
        min=d;
    }
    else 
    {
        min=e;
    }
    
printf("\nMin is equal to %d", min);

avg = (double) (a+b+c+d+e)/5;

printf("\nAverage values is %.2lf", avg);

return 0;   
}