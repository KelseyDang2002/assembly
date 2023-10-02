// Author: Kelsey Dang
// Email: kdangdo2002@csu.fullerton.edu
// Due Date: 9/25/23
// Subject: CPSC 240-03 Assignment 2
// Filename: driver.c
// Purpose: This is the driver file that calls manage for Array Management System.

#include <stdio.h>

extern double manage();

int main(int argc, char* argv[]) {
  printf("\ndriver: Welcome to Array Management System.\n");
  printf("driver: This product is maintained by Kelsey Dang at kdangdo2002@csu.fullerton.edu.\n\n");
  double return_code = manage();
  printf("\ndriver: The main function received %lf ", return_code);
  printf("and will keep it for a while.\n");
  printf("driver: Please consider buying more software from our suite of commercial programs.\n");
  printf("driver: A zero will be returned to to the operating system. Bye.\n");
  return 0;
}
