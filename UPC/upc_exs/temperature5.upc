#include <upc.h>
#include <stdio.h>
#define TBL_SZ 24

main()
{
  static shared int fahrenheit[TBL_SZ];
  static shared int step=10;
  int celsius, i;

  // Note the fourth part of new loop header; i
  // The i indicates affinity, which in this case
  // means iteration i will be performed by
  // thread number (i % THREADS)
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
      printf("%d \t %d \n", fahrenheit[i], celsius); 
    }
}

