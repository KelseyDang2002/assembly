#!/bin/bash

#Author: Kelsey Dang
#Email: kdangdo2002@csu.fullerton.edu
#Due Date: 10/25/23
#Program Name: Arrays
#Filename: r.sh
rm *.o
rm *.out

echo "bash: This is program <Array Management System>"

echo "bash: Compiling driver.c..."
gcc -c -m64 -Wall -fno-pie -no-pie -o driver.o driver.c -std=c17

echo "bash: Assembling manage.asm..."
nasm -f elf64 -l manage.lis -o manage.o manage.asm

echo "bash: Assembling fill_array..."
nasm -f elf64 -l fill_array.lis -o fill_array.o fill_array.asm

echo "bash: Assembling output_array..."
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "bash: Linking the four created object files..."
gcc -m64 -fno-pie -no-pie -o a.out driver.o manage.o fill_array.o output_array.o -std=c17

echo "bash: Running program..."
./a.out

echo "bash: The bash script is now closing..."
