; Program Name: Strings
; Subject: CPSC 240-03 <Strings>
; This program demonstrates string operations with fgets.

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
;   Program Name: Strings
;   Program Languages: C, Assembly X86-64, bash
;   Due Date: 11/12/23
;   Operating System: Tuffix VM on Windows 10 computer

; Purpose
;   This is the faraday file calls isfloat.asm in Strings.
;   This file gets called by ampere.c.

; File Information
;   Filename: faraday.asm
;   Language: Assembly X86-64
;   Compile: nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm
;   Link: gcc -m64 -fno-pie -no-pie -std=c17 -o a.out ampere.o faraday.o isfloat.o

global executive
extern fill_random_array
extern show_array
extern isnan
extern fgets
extern strlen
extern atoi
extern stdin
extern printf
extern scanf
max_size equ 60

segment .data
prompt_name db "executive: Please enter your name: ", 0
prompt_title db "executive: Please enter your title: ", 0
welcome_msg db "executive: Nice to meet you %s %s.", 10, 0

desc_msg db 10, "executive: This program will generate 64-bit IEEE float numbers.", 10, 0
prompt_numbers db "executive: How many numbers do you want? Today's limit is 100 per customer: ", 0
array_msg db "executive: Your numbers have been stored in an array. Here is that array.", 10, 10, 0

normalize_msg_1 db 10, "executive: The array will now be normalized to the range 1.0 to 2.0.", 10, 0
normalize_msg_2 db "executive: Here is the noramlized array.", 10, 10, 0

goodbye_msg db 10, "executive: Good-bye %s. You are welcome any time.", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832
name_array resb max_size
title_array resb max_size
num_array resb max_size
random_num_array resb max_size

segment .text
executive:

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
mov rax, 7
mov rdx, 0
xsave [backuparea]

; =============== Print prompt_name =====================
mov rax, 0
mov rdi, prompt_name
mov rsi, stringform
call printf

; =============== Get name from user ====================
mov rax, 0
mov rdi, name_array
mov rsi, max_size
mov rdx, [stdin]
call fgets

; remove \n char
mov rax, 0
mov rdi, name_array
call strlen
mov byte[name_array+rax-1], byte 0

; =============== Print prompt_title ====================
mov rax, 0
mov rdi, prompt_title
mov rsi, stringform
call printf

; =============== Get title from user ===================
mov rax, 0
mov rdi, title_array
mov rsi, max_size
mov rdx, [stdin]
call fgets

; remove \n char
mov rax, 0
mov rdi, title_array
call strlen
mov byte[title_array+rax-1], byte 0

; =============== Print welcome_msg =====================
mov rax, 0
mov rdi, welcome_msg
mov rsi, title_array
mov rdx, name_array
call printf

; =============== Print desc_msg ========================
mov rax, 0
mov rdi, desc_msg
mov rsi, stringform
call printf

; =============== Print prompt_numbers ==================
mov rax, 0
mov rdi, prompt_numbers
mov rsi, stringform
call printf

; =============== Receive user number input =============
mov rax, 0
mov rdi, num_array
mov rsi, max_size
mov rdx, [stdin]
call fgets

; remove \n char
mov rax, 0
mov rdi, num_array
call strlen
mov byte[num_array+rax-1], byte 0

; convert num_array to integer
mov rax, 0
mov rdi, num_array
call atoi
mov r15, rax

; =============== Print array_msg =======================
mov rax, 0
mov rdi, array_msg
mov rsi, stringform
call printf

; =============== Call fill_random_array ================
mov rax, 0
mov rdi, random_num_array
mov rsi, r15
call fill_random_array

; =============== Call show_array =======================
mov rax, 0
mov rdi, random_num_array
mov rsi, r15
call show_array

; =============== Print normalize_msg_1 =================
mov rax, 0
mov rdi, normalize_msg_1
mov rsi, stringform
call printf

; =============== Print normalize_msg_2 =================
mov rax, 0
mov rdi, normalize_msg_2
mov rsi, stringform
call printf

; =============== Call isnan ============================
mov rax, 0
mov rdi, random_num_array
mov rsi, r15
call isnan

; =============== Call array_msg ========================
mov rax, 0
mov rdi, random_num_array
mov rsi, r15
call show_array

; =============== Print goodbye_msg =====================
mov rax, 0
mov rdi, goodbye_msg
mov rsi, title_array
call printf

; =============== xrstor ================================
mov rax, 7
mov rdx, 0
xrstor [backuparea]

mov rax, name_array

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
