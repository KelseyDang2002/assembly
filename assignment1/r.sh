#!/bin/bash

#Author: Kelsey Dang
#Program Name: Las Vegas Problem

echo "This is program <Las Vegas Problem>"

echo "Assemble the module compute_trip.asm"
nasm -f elf64 -l compute_trip.lis -o compute_trip.o compute_trip.asm

echo "Compile the C++ module main.cpp"
g++ -c -m64 -Wall -o main.o main.cpp -fno-pie -no-pie -std=c++17

echo "Link the two object files already created"
g++ -m64 -o a.out main.o compute_trip.o -fno-pie -no-pie -std=c++17

echo "Run the program Las Vegas Problem"
./a.out

echo "The bash script file is now closing."
