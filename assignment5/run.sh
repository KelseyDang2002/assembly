#!/bin/bash

# Author: Kelsey Dang
# Email: kdangdo2002@csu.fullerton.edu
# Due Date: 11/26/23
# Filename: run.sh
# Purpose: This bash file compiles, links, and executes all the files from Random Numbers.

rm *.o
rm *.out

echo "bash: This is program <Random Numbers>"

echo "bash: Compiling main.c..."
gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o main.o main.c

echo "bash: Assembling executive.asm..."
nasm -f elf64 -l executive.lis -o executive.o executive.asm

echo "bash: Assembling fill_random_array.asm..."
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm

echo "bash: Assembling show_array.asm..."
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm

echo "bash: Assembling isnan.asm..."
nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm

echo "bash: Linking the 5 created object files..."
gcc -m64 -fno-pie -no-pie -std=c17 -o a.out main.o executive.o fill_random_array.o show_array.o isnan.o

echo "bash: Running program..."
./a.out

echo "bash: The bash script is now closing..."
