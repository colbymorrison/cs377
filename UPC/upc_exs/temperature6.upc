#include <upc.h>
#include <stdio.h>
#define TBL_SZ 24

main()
{
  static shared int fahrenheit[TBL_SZ];
  
  // type private ptr to shared int
  // initialized to address of first element of shared array
  shared int *fahrenheit_ptr=fahrenheit; 

  static shared int step=10;
  int celsius, i;

  upc_forall (i=0; i<TBL_SZ; i++; i) 
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

      printf("%d \t %d \n", *fahrenheit_ptr++, celsius); 
      // left-to-right: *fahrenheit_ptr++ deref's pointer first,
      //                so current array element gets printed, then
      //                advances the pointer to next array element 
    }
}

