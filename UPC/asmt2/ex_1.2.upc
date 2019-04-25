#include <upc.h>
#include <stdio.h>
#include <time.h>
// Max temp(100000) * step size(0.0001)
#define TBL_SZ 100000000 

/**
 * Colby Morrison
 * Computes celsius to fahrenheit conversions for celsius intervalse
 * from 0 to 100000 deg. at 0.001 intervals in parallel.
 *
 * With one thread, it completes in about .3 seconds. About 1/3 of time of the sequential 
 * version under UPC.
 */
int main()
{
    clock_t startTime = clock();
    static shared int fahrenheit[TBL_SZ];
    static shared int step=0.0001;
    int celsius, i;

    for (i=MYTHREAD; i<TBL_SZ; i+=THREADS) 
    {
        celsius = step*i;
        fahrenheit[i] = celsius*(9.0/5.0) + 32;
    }

    upc_barrier;

    if (MYTHREAD == 0)
        for (i=0; i<TBL_SZ; i++)
        {
            celsius=step*i;
            //printf("%d \t %d \n", fahrenheit[i], celsius); 
        }

    clock_t endTime = clock();
    printf("Time: %.2fs\n", ((double)(endTime-startTime))/CLOCKS_PER_SEC);
    return 0;
}

