; Program Name: ---
; Subject: CPSC 240-03 <Midterm>
; This program demonstrates passing an array to a called subprogram and sorting it.

; Copyright (C) 2023 Kelsey Dang

; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
; License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it
; will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
; PARTICULAR PURPOSE.  See the GNU General Public License for more details.  A copy of the GNU General Public
; License v3 is available here:  <https://www.gnu.org/licenses/>.

; Author Information
;   Author: Kelsey Dang
;   Email: kdangdo2002@csu.fullerton.edu
;
; Program Information
;   Program Name: ---
;   Program Languages: ---
;   Due Date: 10/25/23
;   Operating System: Tuffix VM on Windows 10 computer

; Purpose
;   This is the director file calls input_array.asm, output_array.c, sortpointers.c in Sort by Pointers.
;   This file gets called by main.cpp.

; File Information
;   Filename: ---
;   Language: x86-64 assembly
;   Compile: nasm -f elf64 -l director.lis -o director.o director.asm
;   Link: g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out main.o director.o input_array.o output_array.o sortpointers.o

extern output_array
extern printf

segment .data
output_data db "%lf ", 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832

segment .text
output_array:

; ============= Backup GPRs ============================
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rsi
push rdi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

; Backup r14 and r15
mov r14, rdi
mov r15, rsi
mov r13, 0

; Print data of array
xor r13, r13

beginloop:
cmp r13, r15
je endloop

movsd xmm0, [r14+8*r13]
mov rax, 1
mov rdi, output_data
call printf

inc r13
jmp beginloop

endloop:
mov rax, r13

; =============== Restore GPRs ==========================
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rdi
pop rsi
pop rdx
pop rcx
pop rbx
pop rbp

ret
