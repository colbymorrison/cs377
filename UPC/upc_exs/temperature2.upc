#include <upc.h>
#include <stdio.h>
#define TBL_SZ 12

main()
{
  static shared int step=10;
  int fahrenheit, celsius, i;

  for (i=0; i<TBL_SZ; i++) 
    if (MYTHREAD == i%THREADS)
    {
      celsius = step*i;
      fahrenheit = celsius*(9.0/5.0) + 32;

      printf("%d \t %d \n", fahrenheit, celsius); 
    }
}

