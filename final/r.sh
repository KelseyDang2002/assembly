#!/bin/bash

# Author: Kelsey Dang
# Email: kdangdo2002@csu.fullerton.edu
# Due Date: 12/6/23
# Filename: r.sh
# Purpose: This bash file compiles, links, and executes all the files from Final.

rm *.o
rm *.out

echo "bash: This is program <Final>"

echo "bash: Compiling main.c..."
gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o main.o main.c

echo "bash: Assembling manager.asm..."
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "bash: Assembling input_array.asm..."
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "bash: Assembling output_array.asm..."
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "bash: Linking the 5 created object files..."
gcc -m64 -fno-pie -no-pie -std=c17 -o a.out main.o manager.o input_array.o output_array.o

echo "bash: Running program..."
./a.out

echo "bash: The bash script is now closing..."
