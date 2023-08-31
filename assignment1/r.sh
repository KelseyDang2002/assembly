#!/bin/bash

#Author: Kelsey Dang
#Program Name: Las Vegas Problem

rm *.o
rm *.out

echo "This is program <Las Vegas Problem>"

echo "Assembling compute_trip.asm..."
nasm -f elf64 -l compute_trip.lis -o compute_trip.o compute_trip.asm

echo "Compiling main.cpp..."
g++ -c -m64 -Wall -o main.o main.cpp -fno-pie -no-pie -std=c++17

echo "Linking the two created object files..."
g++ -m64 -o a.out main.o compute_trip.o -fno-pie -no-pie -std=c++17

echo "Running program..."
./a.out

echo "The bash script file is now closing."
