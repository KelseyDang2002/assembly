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
;   Due Date: 11/12/23
;   Operating System: Tuffix VM on Windows 10 computer

; Purpose
;   This is the director file calls input_array.asm, output_array.c, sortpointers.c in Sort by Pointers.
;   This file gets called by main.cpp.

; File Information
;   Filename: ---
;   Language: x86-64 assembly
;   Compile: nasm -f elf64 -l director.lis -o director.o director.asm
;   Link: g++ -m64 -fno-pie -no-pie -std=c++17 -o a.out main.o director.o input_array.o output_array.o sortpointers.o

extern faraday
extern printf

segment .data
prompt_name db "faraday: Please enter your name: ", 0
prompt_title db 10, "faraday: Please enter your title or profession: ", 0

welcome_msg db 10, "faraday: We always welcome a %s to our electrical lab.", 10, 0

prompt_volts db 10, "faraday: Please enter the voltage of the electrical system at your site (volts): ", 0
prompt_ohms db 10, "faraday: Please enter the electrical resistence in the system at your site (ohms): ", 0
prompt_seconds db 10, "faraday: Please enter the time your system was operating (seconds): ", 0

thankyou_msg_1 db 10, 10, "faraday: Thank you %s. ", 0
thankyou_msg_2 db "We at Majestic are pleased to inform you that your system performed %lf joules of work.", 10, 0

congrats_msg_1 db 10, "faraday: Congratulations %s. Come back any time and make use of our software.", 10, 0
congrats_msg_2 db "Everyone with title %s is welcome to use our programs at a reduced price.", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss

segment .text
faraday:

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

; =============== Print prompt_name =====================
mov rax, 0
mov rdi, stringform
mov rsi, prompt_name
call printf

; =============== Print prompt_title ====================
mov rax, 0
mov rdi, stringform
mov rsi, prompt_title
call printf

; =============== Print welcome_msg =====================
mov rax, 0
mov rdi, stringform
mov rsi, welcome_msg
call printf

; =============== Print prompt_volts ====================
mov rax, 0
mov rdi, stringform
mov rsi, prompt_volts
call printf

; =============== Print prompt_ohms =====================
mov rax, 0
mov rdi, stringform
mov rsi, prompt_ohms
call printf

; =============== Print prompt_seconds ==================
mov rax, 0
mov rdi, stringform
mov rsi, prompt_seconds
call printf

; =============== Print thankyou_msg_1 ==================
mov rax, 0
mov rdi, stringform
mov rsi, thankyou_msg_1
call printf

; =============== Print thankyou_msg_2 ==================
mov rax, 0
mov rdi, stringform
mov rsi, thankyou_msg_2
call printf

; =============== Print congrats_msg_1 ==================
mov rax, 0
mov rdi, stringform
mov rsi, congrats_msg_1
call printf

; =============== Print congrats_msg_2 ==================
mov rax, 0
mov rdi, stringform
mov rsi, congrats_msg_2
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
