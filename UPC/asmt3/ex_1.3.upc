#include<upc.h>
#include<stdlib.h>
#include<stdio.h>
#include<time.h>

int main () {
  clock_t startTime = getTimeMilis();
  static shared int temps[TBL_SZ][TBL_SZ];
  shared int *fahrenheit_ptr;
  shared int *celsius_ptr;
  static shared int step=10; int celsius, i;
  celsius_ptr = (temps + MYTHREAD)[0];
  fahrenheit_ptr = temps[1] ;
  upc_forall(i=0; i <TBL_SZ; i++; i) {
    celsius = step*i;
    *celsius_ptr = celsius;
    *fahrenheit_ptr = celsius*(9.0/5.0) + 32;
    celsius_ptr += THREADS;
  }
  upc_barrier;
  if(MYTHREAD==0)
  {
    fahrenheit_ptr=fahrenheit;
    for (i=0; i < TBL_SZ ; i++, fahrenheit_ptr++) {
      celsius=  
      //printf ("%d \t %d \n", *fahrenheit_ptr, celsius); }
  }
  clock_t endTime = getTimeMilis();
  printf("Time: .2%fs", endTime-startTime);
  return 0;
}
