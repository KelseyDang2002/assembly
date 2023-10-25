#!/bin/bash

# Author: Kelsey Dang
# Email: kdangdo2002@csu.fullerton.edu
# Due Date: 10/25/23
# Filename: r.sh
# Purpose: This bash file compiles, links, and executes all the files from Sort by Pointers.

rm *.o
rm *.out

echo "bash: This is program <Midterm>"

echo "bash: Compiling main.c..."
gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o main.o main.c

echo "bash: Assembling manager.asm..."
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "bash: ..."

echo "bash: ..."

echo "bash: Linking the _ created object files..."
gcc -m64 -fno-pie -no-pie -std=c17 -o a.out main.o manager.o

echo "bash: Running program..."
./a.out

echo "bash: The bash script is now closing..."
