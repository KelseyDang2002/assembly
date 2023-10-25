; Program Name: ---
; Subject: CPSC 240-03 Assignment 3 <--->
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

global manager
extern printf

segment .data
test_msg db "manager: World!", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss

segment .text
manager:

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

; Block
mov rax, 0
mov rdi, stringform
mov rsi, test_msg
call printf

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

; =============== Sendback to main ======================
; mov rax, sendback

ret
