// Author: Kelsey Dang
// Email: kdangdo2002@csu.fullerton.edu
// Due Date: 10/1/23
// Subject: CPSC 240-03 Assignment 3 <Sort by Pointers>
// Filename: main.cpp
// Purpose: This is the driver file that calls director.asm in Sort by Pointers.

#include <stdio.h>
#include <iostream>

using namespace std;

extern "C" unsigned long* director();

int main() {
  cout << "\nmain: Welcome to Sort by Pointers by Kelsey Dang.\n\n";
  unsigned long *return_array = director();
  cout << "\nmain: The main function receieved this set of numbers:\n\n";
  // for(int i = 0; i < max_size, i++) {
  printf("main: %ln", return_array);
  // }
  cout << "\n\nmain: Main will keep these and send a zero to the operating system.\n";
  return 0;
}
