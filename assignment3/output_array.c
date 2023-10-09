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
//   This file outputs the elements on the array in Sort by Pointers.
//   This file gets called by director.asm.

// File Information
//   Filename: output_array.c
//   Language: C
//   Compile: gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o sortpointers.o sortpointers.c
//   Link: g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out main.o director.o input_array.o output_array.o sortpointers.o

#include <stdio.h>

void output_array(double* array[], int max_size){
  for (int i = 0; i < max_size; i++) {
    printf("output_array: %16.8lf\n", *array[i]);
  }
}
