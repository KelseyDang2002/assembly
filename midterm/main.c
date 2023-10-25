// Program Name: ---
// Subject: CPSC 240-03 <Midterm>
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
//   Program Name: ---
//   Program Languages: ---
//   Due Date: 10/25/23
//   Operating System: Tuffix VM on Windows 10 computer

// Purpose
//   This is the driver file that calls director.asm in Sort by Pointers.

// File Information
//   Filename: ---
//   Language: ---
//   Compile: g++ -c -m64 -Wall -fno-pie -no-pie -std=c++17 -o main.o main.cpp
//   Link: g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out main.o director.o input_array.o output_array.o sortpointers.o

#include <stdio.h>

extern double manager();

int main(int argc, char* argv[]) {
  printf("main: Hello, \n");
  manager();
  return 0;
}
