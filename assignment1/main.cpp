// Author: Kelsey Dang
// Email: kdangdo2002@csu.fullerton.edu
// Due Date: 10/4/23
// Subject: CPSC 240-03 Assignment 1
// Filename: main.cpp

#include <iostream>
#include <stdio.h>

using namespace std;

extern "C" double las_vegas();

// Driver Code
int main() {
  double number;
  cout << "\nWelcome to Trip Advisor by Kelsey Dang.\n";
  cout << "We help you plan your trip.\n\n";

  // Call assembly module
  number = las_vegas();

  // Output number received
  printf("%s%1.18lf%s\n", "\nThe main module received this number ", number,
  " and will keep it for a while.\n");
  cout << "A zero will be sent to your operating system.\n";
  cout << "Good-bye. Have a great trip.\n";
  return 0;
}
