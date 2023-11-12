// Program Name: Strings
// Subject: CPSC 240-03 <String>
// This program demonstrates string operations with fgets.

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
//   Program Name: Strings
//   Program Languages: C, Assembly X86-64, bash
//   Due Date: 11/12/23
//   Operating System: Tuffix VM on Windows 10 computer

// Purpose
//   This is the driver file that calls faraday.asm in Strings.

// File Information
//   Filename: ampere.c
//   Language: C
//   Compile: gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o ampere.o ampere.c
//   Link: gcc -m64 -fno-pie -no-pie -std=c17 -o a.out ampere.o faraday.o isfloat.o

#include <stdio.h>

extern double faraday();

int main(int argc, char* argv[]) {
  printf("\nampere: Welcome to Majestic Power Systems, LLC\n");
  printf("ampere: Project Director, Sharon Winners, Senior Software Engineer.\n\n");
  double return_code = faraday();
  printf("\nampere: The main function receieved this number %.2lf", return_code);
  printf(" and will keep it for future study.\n");
  printf("ampere: A zero will be returned to the operating system. Bye.\n\n");
  return 0;
}
