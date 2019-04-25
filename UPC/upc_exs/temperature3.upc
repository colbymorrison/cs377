#include <upc.h>
#include <stdio.h>
#define TBL_SZ 12

main()
{
  static shared int fahrenheit[TBL_SZ]; // array shared by all threads
  static shared int step=10;
  int celsius, i;

  // each thread calculates its own respective temperature conversions
  // and stores resuls in corresponding location withing shared array.
  for (i=MYTHREAD; i<TBL_SZ; i+=THREADS) 
  {
    celsius = step*i;
    fahrenheit[i] = celsius*(9.0/5.0) + 32;
  }

  if (MYTHREAD == 0)
    for (i=0; i<TBL_SZ; i++)
    {
      celsius=step*i;
      printf("%d \t %d \n", fahrenheit[i], celsius); 
    }
}

