#include<stdlib.h>
#include<stdio.h>
#include<upc.h>

#define VEC_SZ 13 

/**
* Colby Morrison
* Computes the mean of shared array of general size
*/
int main(){
    static shared int arr[VEC_SZ] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};
    static shared int partialSum[THREADS];
    int i;

    // Use upc_forall instead of standard for loop
    upc_forall(i = MYTHREAD; i < VEC_SZ; i++; i){
        partialSum[MYTHREAD] += arr[i];
    }
 
    upc_barrier;

    // First thread sums partialSums to calculate mean    
    if(MYTHREAD == 0){
        int sum = 0;
        for(i = 0; i < THREADS; i++)
            sum += partialSum[i];

        printf("%0.1f\n", ((double)sum) / VEC_SZ);
    }
    return 0;
}
        
