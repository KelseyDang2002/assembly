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
//   This is the driver file that calls director.asm in Sort by Pointers.

// File Information
//   Filename: main.cpp
//   Language: C++
//   Compile: g++ -c -m64 -Wall -fno-pie -no-pie -std=c++17 -o main.o main.cpp
//   Link: g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out main.o director.o input_array.o output_array.o sortpointers.o

#include <stdio.h>
#include <iostream>

using namespace std;

extern "C" unsigned long* director();

int main() {
  cout << "\nmain: Welcome to Sort by Pointers by Kelsey Dang.\n\n";

  unsigned long* return_array = director();
  int size_of_array = (int)return_array[0];
  double** ptr_array = (double**)return_array[1];

  cout << "main: The main function receieved this set of numbers:\n\n";
  for(int i = 0; i < size_of_array; i++) {
    printf("main: %16.8lf\n", *(ptr_array[i]));
  }

  cout << "\nmain: Main will keep these and send a zero to the operating system.\n";
  return 0;
}
