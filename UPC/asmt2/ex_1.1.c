#include<stdlib.h>
#include<stdio.h>
#include<time.h>

/*
 * Colby Morrison 
 * Computes celsius to farenhiet conversions
 * for celsius intervals from 0 to 100000 deg.
 * at 0.0001 intervals sequentially. 
 * 
 * When compiling with gcc and running times
 * are around 6 seconds. When running with
 * upcrun, times are around 1 second!
 */
int main(){
    clock_t startTime = clock();
    int maxC = 100000;
    double farenheit;
    for(double i=0; i < maxC; i+=0.0001){
        farenheit = i*(9.0/5.0) + 32;
        printf("%.2f \t %.2f \n", farenheit, i);
    }
    clock_t endTime = clock();
    double cpuTime = ((double) (endTime - startTime)) / CLOCKS_PER_SEC;
    printf("Time: %.2fs\n", cpuTime);
    return 0;
}
