// Author: Kelsey Dang
// Email: kdangdo2002@csu.fullerton.edu
// Due Date: 10/1/23
// Subject: CPSC 240-03 Assignment 3 <Sort by Pointers>
// Filename: sortpointers.asm
// Purpose: This file sorts the elements in the array.

#include <stdio.h>
#include <iostream>

using namespace std;

extern "C" {
  // sortpointers function uses bubblesort
  int sortpointers(unsigned long* array[], long max_size) {
    printf("sortpointers: test call\n");
    // outer loop goes through elements in array
    for (int step = 0; step < max_size; step++) {
      // inner loop compares 2 consecutive elements at a time
      for (int i = 0; i < max_size - step; i++) {
        // compare an element with the next element
        if (*array[i] > *array[i + 1]) {
          // swap places if next element is smaller
          int temp = *array[i];
          *array[i] = *array[i + 1];
          *array[i + 1] = temp;
        }
      }
    }
    return array[0];
  }
}
