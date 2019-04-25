#include<upc.h>
#include<stdlib.h>
#include<stdio.h>
#include<time.h>

int main () {
  clock_t startTime = getTimeMilis();
  static shared int fahrenheit [TBL_SZ];
  shared int *fahrenheit_ ptr;
  static shared int step=10; int celsius, i;
  fahrenheit_ptr = fahrenheit + MYTHREAD;
  upc_forall(i=0; i <TBL_SZ; i++; i) {
    celsius = step*i;
    *fahrenheit_ptr = celsius*(9.0/5.0) + 32;
    fahrenheit_ptr += THREADS;
  }
  upc_barrier;
  if(MYTHREAD==0)
  {
    fahrenheit_ptr=fahrenheit;
    for (i=0; i < TBL_SZ ; i++, fahrenheit_ptr++) {
      celsius= step*i;
      //printf ("%d \t %d \n", *fahrenheit_ptr, celsius); }
  }
  clock_t endTime = getTimeMilis();
  printf("Time: .2%fs", endTime-startTime);
  return 0;
}
