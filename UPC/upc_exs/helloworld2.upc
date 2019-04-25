#include <upc.h>
#include <stdio.h>

main()
{
  printf("Thread %d of %d: hello UPC world\n", 
         MYTHREAD, THREADS);
}

