; Program Name: Sort by Pointers
; Subject: CPSC 240-03 Assignment 3 <Sort by Pointers>
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
;   Program Name: Sort by Pointers
;   Program Languages: One module in C++, two in x86-64, two in C, one in bash
;   Due Date: 10/1/23
;   Operating System: Tuffix VM on Windows 10 computer

; Purpose
;   This input_array receives user input in Sort by Pointers.
;   This file gets called by director.asm.

; File Information
;   Filename: input_array.asm
;   Language: x86-64 assembly
;   Compile: nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
;   Link: g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out main.o director.o input_array.o output_array.o sortpointers.o

global input_array
extern malloc
extern scanf

segment .data
floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832
sendback resq 2

segment .text
input_array:

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

; =============== xsave =================================
mov rax, 10
mov rdx, 0
xsave [backuparea]

; =============== Backup r14 and r15 ====================
mov r14, rdi          ; r14 is the array
mov r15, rsi          ; r15 is the size of array
mov r13, 0            ; r13 is the starting index 0

; =============== Receive input from user ===============
xor r13, r13          ; r13 is the is the starting index 0

beginloop:
cmp r13, r15          ; compare index and size of array
jge endloop           ; end the loop if index >= size of array

mov rax, 0
mov rdi, 8            ; 8 bytes
call malloc           ; move 8 bytes into heap

mov r12, rax
mov rdi, floatform    ; %lf
mov rsi, r12
call scanf            ; receive user input

cdqe                  ; convert double to quad and extend
cmp rax, -1           ; check for CTRL + D
je endloop            ; jump to end of loop if CTRL + D

mov [r14+8*r13], r12
inc r13               ; increment r13 (i++)
jmp beginloop         ; start loop again

endloop:

; =============== xrstor ================================
; mov rax, 10
; mov rdx, 0
; xrstor [backuparea]

mov rax, r13

; mov rax, 2
; movsd xmm0, [r14]
; movsd xmm1, [r14+8]

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
