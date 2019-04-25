#include<upc.h>
#include<stdlib.h>
#include<stdio.h>
#include<time.h>

#define TBL_SZ 15

/*
* Colby Morrison
* Calculates farenhiet to celsius conversions in parallel using a 
* two-dimensional array to store values.
*/
int main () {
    static shared int temps[TBL_SZ][TBL_SZ];
    static shared int step=10;
    shared int *row;
    int celsius, i;

    for(i=MYTHREAD; i <TBL_SZ; i+=THREADS) {
        // Get a pointer to current row
        row = temps[i];
        celsius = step*i; 
        // First elt. of row is c, second is f
        row[0] = celsius;
        row[1] = celsius*(9.0/5.0) + 32;
    }

    upc_barrier;

    // First thread prints out final values
    if(MYTHREAD==0)
    {
        for (i=0; i < TBL_SZ ; i++){
            row = temps[i];
            printf("%d \t %d\n", row[0], row[1]);
        }
        return 0;
    }
}
