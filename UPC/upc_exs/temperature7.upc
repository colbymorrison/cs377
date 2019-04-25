#include <upc.h>
#include <stdio.h>
#define TBL_SZ 24

main()
{
  static shared int fahrenheit[TBL_SZ];
  
  // type private ptr to shared int:
  // - fahrenheit_ptr itself is private
  // - what it points to is shared
  shared int *fahrenheit_ptr; 

  static shared int step=10;
  int celsius, i;

  fahrenheit_ptr = fahrenheit + MYTHREAD;

  upc_forall (i=0; i<TBL_SZ; i++; i) 
  {
    celsius = step*i;
    *fahrenheit_ptr = celsius*(9.0/5.0) + 32;
    fahrenheit_ptr += THREADS;
  }

  upc_barrier;

  if (MYTHREAD == 0)
  {
    fahrenheit_ptr = fahrenheit;
    for (i=0; i<TBL_SZ; i++, fahrenheit_ptr++)
    {
      celsius=step*i;
      printf("%d \t %d \n", *fahrenheit_ptr, celsius); 
    }
  }
}

