#!/bin/bash

# Author: Kelsey Dang
# Email: kdangdo2002@csu.fullerton.edu
# Due Date: 10/1/23
# Filename: rg.sh
# Purpose: This bash file compiles, links, and executes all the files from Sort by Pointers.

rm *.o
rm *.out

echo "bash: This is program <Sort by Pointers>"

echo "bash: Compiling main.cpp..."
g++ -c -m64 -Wall -fno-pie -no-pie -std=c++17 -o main.o main.cpp -g

echo "bash: Assembling director.asm..."
nasm -f elf64 -l director.lis -o director.o director.asm -gdwarf

echo "bash: Assembling input_array.asm..."
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm -gdwarf

echo "bash: Compiling output_array.c..."
gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o output_array.o output_array.c -g

echo "bash: Compiling challenge_sort.asm..."
nasm -f elf64 -l director.lis -o challenge_sort.o challenge_sort.asm -gdwarf

echo "bash: Linking the 5 created object files..."
g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out main.o director.o input_array.o output_array.o challenge_sort.o -g

echo "bash: Running program..."
gdb ./a.out

echo "bash: The bash script is now closing..."
