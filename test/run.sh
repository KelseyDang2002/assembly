#!/bin/bash

rm *.o
rm *.out

echo "bash: This is program <Test>"

echo "bash: Compiling main.c..."
gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.c -std=c17

echo "bash: Assembling assembly.asm..."
nasm -f elf64 -l assembly.lis -o assembly.o assembly.asm

echo "bash: Linking the two created object files..."
gcc -m64 -fno-pie -no-pie -o a.out main.o assembly.o -std=c17

echo "bash: Running program..."
./a.out

echo "bash: The bash script is now closing..."
