#!/bin/bash

# Author: Kelsey Dang
# Email: kdangdo2002@csu.fullerton.edu
# Due Date: 11/12/23
# Filename: r.sh
# Purpose: This bash file compiles, links, and executes all the files from Strings.

rm *.o
rm *.out

echo "bash: This is program <Strings>"

echo "bash: Compiling ampere.c..."
gcc -c -m64 -Wall -fno-pie -no-pie -std=c17 -o ampere.o ampere.c

echo "bash: Assembling faraday.asm..."
nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm

echo "bash: Linking the 2 created object files..."
gcc -m64 -fno-pie -no-pie -std=c17 -o a.out ampere.o faraday.o

echo "bash: Running program..."
./a.out

echo "bash: The bash script is now closing..."
