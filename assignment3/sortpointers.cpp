// Program Name: Sort by Pointers
// Subject: CPSC 240-03 Assignment 3 <Sort by Pointers>
// This program demonstrates passing an array to a called subprogram and sorting it.

// Copyright (C) 2023 Kelsey Dang

// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
// License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it
// will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
// PARTICULAR PURPOSE.  See the GNU General Public License for more details.  A copy of the GNU General Public
// License v3 is available here:  <https://www.gnu.org/licenses/>.

// Author Information
//   Author: Kelsey Dang
//   Email: kdangdo2002@csu.fullerton.edu

// Program Information
//   Program Name: Sort by Pointers
//   Program Languages: One module in C++, two in x86-64, two in C, one in bash
//   Due Date: 10/1/23
//   Operating System: Tuffix VM on Windows 10 computer

// Purpose
//   This file sorts the elements on the array in ascending order in Sort by Pointers.
//   This file gets called by director.asm.

// File Information
//   Filename: sortpointers.c
//   Language: C
//   Compile: gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o sortpointers.o sortpointers.c
//   Link: g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out main.o director.o input_array.o output_array.o sortpointers.o

#include <iostream>

// sortpointers function uses bubblesort
extern "C" {
  int sortpointers(double* array[], int max_size) {
    // printf("sortpointers: test call\n");
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
