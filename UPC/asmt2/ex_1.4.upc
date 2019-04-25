#include<stdlib.h>
#include<stdio.h>
#include<upc.h>

#define VEC_SZ 8

/**
* Colby Morrison
* Sums 2 shared vectors in parallel
*/
int main(){
    // Define vectors
    static shared int vec1[VEC_SZ] = {1, 2, 3, 4, 5, 6, 7, 8};
    static shared int vec2[VEC_SZ] = {1, 2, 3, 4, 5, 6, 7, 8};
    static shared int vecSum[VEC_SZ];
    int i;

    // Each thread sums values with its affinity
    for(i = MYTHREAD; i< VEC_SZ; i+=THREADS)
        vecSum[i] = vec1[i] + vec2[i];

    upc_barrier;
    
    // First thread prints out sum
    if(MYTHREAD == 0){
        for(i = 0; i < VEC_SZ; i++)
            if(i == VEC_SZ - 1)
                printf("%d\n", vecSum[i]);
            else
                printf("%d, ", vecSum[i]);
    }
    return 0;
}
        
