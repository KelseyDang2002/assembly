// Program Name: Random Numbers
// Subject: CPSC 240-03 <Random Numbers>
// This program demonstrates non-deterministic random number generation.

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
//   Program Name: Random Numbers
//   Program Languages: C, Assembly X86-64, bash
//   Due Date: ---
//   Operating System: Tuffix VM on Windows 10 computer

// Purpose
//   This is the driver file that calls executive.asm in Random Numbers.

// File Information
//   Filename: main.c
//   Language: C
//   Compile: gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o main.o main.c
//   Link: gcc -m64 -fno-pie -no-pie -std=c17 -o a.out main.o executive.o fill_random_array.o show_array.o isnan.o

#include <stdio.h>

extern char * executive();

int main(int argc, char* argv[]) {
  printf("\nmain: Welcome to Random Products, LLC.\n");
  printf("main: This software is maintained by Alfred Findelstein\n\n");
  char * return_code = executive();
  printf("\nmain: Oh, %s. We hope you enjoy your arrays. Do come again.\n", return_code);
  printf("main: A zero will be returned to the operating system.\n\n");
  return 0;
}
