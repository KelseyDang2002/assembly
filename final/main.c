// Program Name: Final
// Subject: CPSC 240-03 <Final>
// This program is for the Final Program Exam.

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
//   Program Name: Final
//   Program Languages: C, Assembly X86-64, bash
//   Due Date: 12/6/23
//   Operating System: Tuffix VM on Windows 10 computer

// Purpose
//   ---

// File Information
//   Filename: main.c
//   Language: C
//   Compile: gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o main.o main.c
//   Link:

#include <stdio.h>

extern char * manager();

int main(int argc, char* argv[]) {
  printf("\nmain: Welcome to Array Management System\n");
  printf("main: This product is maintained by Kelsey Dang at kdangdo2002@csu.fullerton.edu\n\n");
  char * return_code = manager();
  printf("\nmain: The main function received %s and will keep it for a while.\n", return_code);
  printf("main: Please condider buying more software from our suite of commercial programs.\n");
  printf("main: A zero will be returned to the operating system. Bye.\n\n");
  return 0;
}
