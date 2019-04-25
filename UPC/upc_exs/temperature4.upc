#include <upc.h>
#include <stdio.h>
#define TBL_SZ 24

main()
{
  static shared int fahrenheit[TBL_SZ];
  static shared int step=10;
  int celsius, i;

  for (i=MYTHREAD; i<TBL_SZ; i+=THREADS) 
  {
    celsius = step*i;
    fahrenheit[i] = celsius*(9.0/5.0) + 32;
  }

  // barrier divides program into "supersteps", 1 before and 1 after
  upc_barrier;

  if (MYTHREAD == 0)
    for (i=0; i<TBL_SZ; i++)
    {
      celsius=step*i;
      printf("%d \t %d \n", fahrenheit[i], celsius); 
    }
}

