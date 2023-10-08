// Author: Kelsey Dang
// Email: kdangdo2002@csu.fullerton.edu
// Due Date: 10/1/23
// Subject: CPSC 240-03 Assignment 3 <Sort by Pointers>
// Filename: output_array.cpp
// Purpose: This file prints the elements in the array.

#include <stdio.h>
#include <iostream>

using namespace std;

extern "C" {
  void output_array(double* array[], long max_size){
    for (int i = 0; i < max_size; i++) {
      printf("output_array: %16.8lf\n", *array[i]);
    }
  }
}
