// Author: Kelsey Dang
// Email: kdangdo2002@csu.fullerton.edu
// Due Date: 10/25/23
// Subject: CPSC 240-03 Assignment 2
// Filename: driver.c

#include <stdio.h>

extern double manage();

int main(int argc, char* argv[]) {
  printf("\nWelcome to Array Management System.\n");
  printf("This product is maintained by Kelsey Dang at kdangdo2002@csu.fullerton.edu.\n\n");
  double return_code = manage();
  printf("\nThe main function received %lf ", return_code);
  printf("and will keep it for a while.\n");
  printf("Please consider buying more software from our suite of commercial programs.\n");
  printf("A zero will be returned to to the operating system. Bye.\n");
  return 0;
}
