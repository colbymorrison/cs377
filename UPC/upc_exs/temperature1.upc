#include <upc.h>
#include <stdio.h>

main()
{
  static shared int step=10;
  int fahrenheit, celsius;

  celsius = step*MYTHREAD;
  fahrenheit = celsius*(9.0/5.0) + 32;

  printf("%d \t %d \n", fahrenheit, celsius); 
}

