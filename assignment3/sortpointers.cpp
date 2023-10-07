// Author: Kelsey Dang
// Email: kdangdo2002@csu.fullerton.edu
// Due Date: 10/1/23
// Subject: CPSC 240-03 Assignment 3 <Sort by Pointers>
// Filename: sortpointers.asm
// Purpose: This file sorts the elements in the array.

#include <stdio.h>
#include <iostream>

using namespace std;

extern "C" {void sortpointers(double* array[], long max_size);}

void sortpointers(double* array[], long max_size) {
  for (double step = 0; step < max_size; step++) {
    for (int i = 0; i < max_size - step; i++) {
      if (**array[i] > **array[i + 1]) {
        int temp = **array[i];
        *array[i] = **array[i + 1];
        *array[i + 1] = temp;
      }
    }
  }
}
