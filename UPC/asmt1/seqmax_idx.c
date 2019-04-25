#include<stdlib.h>
#include<stdio.h>

/*Program: seqmax_idx.c
* Author: Colby Morrison
*
* Description:
* Write a program that finds the max of N numbers. The program will
* prompt the user for a list of numbers, which will be read from
* stdin using the C library function, scanf().
*
* This program will use arrays, which in C are just pointers. This 
* version of the program uses array notation ([]s). 
*
* Fill an array of int values, prompting the user from stdin;
* echo the list of numbers entered, then find the max and print it
*/

/*
* initialize n elements of numbers array to -1
*/
void init_numbers(int n, int* numbers)
{
  for(int i = 0; i < n; i++){
    numbers[i] = -1; 
  }
}

/*
* print n elements of numbers array
*/ 
void print_numbers(int n, int* numbers)
{
  for(int i = 0; i < n; i++){
    printf("%d ", numbers[i]);
    if(i == n-1)
      printf("\n");
  }
}

/*
* read n numbers from stdin
*/
int read_numbers(int n, int* numbers)
{
    // Use the scanf function to read numbers into arrray
    for(int i = 0; i < n; i++){
        printf("Enter number: ");
        int n = scanf("%d", &numbers[i]);
        // Check for scanf error
        if(n != 1)
            return 1;
    }
    
    return 0;
}

/*
 * find max from first n numbers in given array
 */
int find_max(int n, int* numbers)
{
  // Current maximum
  int max = numbers[0];
  // Update max if any elt. of the array is larger than max
  for(int i = 1; i < n; i++){
    int val = numbers[i];
    if (val > max)
      max = val;
  } 
  return max;
}

int main()
{  
  // Number of elements
  int num_elts;
  printf("Enter number of elements: ");
  scanf("%d", &num_elts);

  // Create an array with the requested number of elements
  int numbers[num_elts];
  init_numbers(num_elts, numbers); 
  // Make sure all numbers were correctly read
  int read = read_numbers(num_elts, numbers);
  if(read){
    printf("Error reading your numbers");
    return 1;
  }
     
  printf("You entered ");
  print_numbers(num_elts, numbers);
  printf("Max number is %d\n", find_max(num_elts, numbers));
  return 0;
}
