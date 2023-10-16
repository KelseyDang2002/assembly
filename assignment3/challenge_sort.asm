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
;   This file sorts elements in the array in ascending order in Sort by Pointers.
;   This file gets called by director.asm.

; File Information
;   Filename: challenge_sort.asm
;   Language: x86-64 assembly
;   Compile: nasm -f elf64 -l director.lis -o challenge_sort.o challenge_sort.asm
;   Link: g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out main.o director.o input_array.o output_array.o sortpointers.o

global challenge_sort
extern printf

segment .data
debug_msg db "challenge_sort: called", 10, 0

stringform db "%s", 0

segment .bss
align 64
backuparea resb 832

segment .text
challenge_sort:

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
; mov rax, 10
; mov rdx, 0
; xsave [backuparea]

; =============== test call =============================
; mov rax, 0
; mov rdi, stringform
; mov rsi, debug_msg
; call printf

; =============== Backup r14 and r15 ====================
mov r14, rdi          ; r14 is the array
mov r15, rsi          ; r15 is the size of the array
mov r13, -1           ; index for outter loop (step)
mov r12, 0            ; index for inner loop (i)

; =============== challenge_sort ========================
outerloop:
inc r13               ; r13 is now index 0
cmp r13, r15          ; compare index and size of array
jge endloop           ; end loop if index >= size of array

mov r12, 0            ; resets counter of inner loop (i)
jmp innerloop         ; continue to inner loop

innerloop:
mov r11, r15          ; copy r15 (size) into r11
sub r11, r13          ; r11 is size - step (r15 - r13)
cmp r12, r11          ; compare i with (size - step)
jge outerloop

lea r10, [r14+8*r12]  ; **array[i]
movsd xmm15, [r10]
inc r12
lea r9, [r14+8*(r12+1)] ; **array[i + 1]
movsd xmm14, [r9]
ucomisd xmm15, xmm14
jge swap

swap:
; mov rbx, [r10]
; mov rcx, [r9]
;
; mov [r10], rcx
; mov [r9], rbx

mov r8, r12
movsd [r14+8*r8], xmm15
add r8, 1
movsd [r14+8*r8], xmm14
jmp innerloop

endloop:
; =============== xrstor ================================
; mov rax, 10
; mov rdx, 0
; xrstor [backuparea]

mov rax, r14

; mov rax, 2
; movsd xmm0, xmm15
; movsd xmm1, xmm14

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
