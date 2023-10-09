#!/bin/bash

# Author: Kelsey Dang
# Email: kdangdo2002@csu.fullerton.edu
# Due Date: 10/1/23
# Filename: r.sh
# Purpose: This bash file compiles, links, and executes all the files from Sort by Pointers.

rm *.o
rm *.out

echo "bash: This is program <Sort by Pointers>"

echo "bash: Compiling main.cpp..."
g++ -c -m64 -Wall -fno-pie -no-pie -std=c++17 -o main.o main.cpp

echo "bash: Assembling director.asm..."
nasm -f elf64 -l director.lis -o director.o director.asm

echo "bash: Assembling input_array.asm..."
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "bash: Compiling output_array.c..."
gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o output_array.o output_array.c

echo "bash: Compiling sortpointers.c..."
g++ -c -m64 -Wall -fno-pie -no-pie -std=c++17 -o sortpointers.o sortpointers.cpp

echo "bash: Linking the 5 created object files..."
g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out main.o director.o input_array.o output_array.o sortpointers.o

echo "bash: Running program..."
./a.out

echo "bash: The bash script is now closing..."
