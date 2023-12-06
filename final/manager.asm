; Program Name: Final
; Subject: CPSC 240-03 <Final>
; This program is for the Final Program Exam.
;
; Copyright (C) 2023 Kelsey Dang
;
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
; License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it
; will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
; PARTICULAR PURPOSE.  See the GNU General Public License for more details.  A copy of the GNU General Public
; License v3 is available here:  <https://www.gnu.org/licenses/>.
;
; Author Information
;   Author: Kelsey Dang
;   Email: kdangdo2002@csu.fullerton.edu
;
; Program Information
;   Program Name: Final
;   Program Languages: C, Assembly X86-64, bash
;   Due Date: 12/6/23
;   Operating System: Tuffix VM on Windows 10 computer
;
; Purpose
;   ---
;
; File Information
;   Filename: manager.asm
;   Language: Assembly X86-64
;   Compile: nasm -f elf64 -l manager.lis -o manager.o manager.asm
;   Link:

global manager
extern input_array
extern output_array
extern fgets
extern strlen
extern atoi
extern stdin
extern stdout
extern printf
extern scanf
max_size equ 25

segment .data
care_msg db "manager: We will take care of all your array needs.", 10, 0
prompt_input db "manager: Please input how many numbers you want. The limit is 100: ", 0
prompt_delay db "manager: What is the delay time you prefer (seconds)? ", 0
prompt_frequency db "manager: What is the maximum frequency of your cpu (GHz)? ", 0
array_msg db "manager: Here are the values in the array.", 10, 10, 0
display_msg db 10, "manager: The numbers of the array have been displayed.", 10, 0
thankyou_msg db "manager: Thank you for using Array Management System.", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832
num_array resb max_size
random_num_array resb max_size

delay_array resb max_size
frequency_array resb max_size

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

; =============== xsave =================================
mov rax, 7
mov rdx, 0
xsave [backuparea]

; =============== Print care_msg ========================
mov rax, 0
mov rdi, care_msg
call printf

; =============== Print prompt_input ====================
mov rax, 0
mov rdi, prompt_input
call printf

; =============== Receive count =========================
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

; =============== Call input_array ======================
mov rax, 0
mov rdi, random_num_array
mov rsi, r15
call input_array

; =============== Print prompt_delay ====================
mov rax, 0
mov rdi, prompt_delay
call printf

; get user input
mov rax, 0
mov rdi, delay_array
mov rsi, max_size
mov rdx, [stdin]
call fgets

; remove \n char
mov rax, 0
mov rdi, delay_array
call strlen
mov byte[delay_array+rax-1], byte 0

; convert num_array to integer
mov rax, 0
mov rdi, delay_array
call atoi
mov r11, rax

; =============== Print prompt_frequency ================
mov rax, 0
mov rdi, prompt_frequency
call printf

; get user input
mov rax, 0
mov rdi, frequency_array
mov rsi, max_size
mov rdx, [stdin]
call fgets

; remove \n char
mov rax, 0
mov rdi, frequency_array
call strlen
mov byte[frequency_array+rax-1], byte 0

; convert num_array to integer
mov rax, 0
mov rdi, frequency_array
call atoi
mov r12, rax

; =============== frequency * delay =====================
imul r12, r11

; =============== Print array_msg =======================
mov rax, 0
mov rdi, array_msg
call printf

; =============== Call output_array =====================
mov rax, 0
mov rdi, random_num_array
mov rsi, r15
mov rdx, rcx
call output_array

; =============== Print display_msg =====================
mov rax, 0
mov rdi, display_msg
call printf

; =============== Print thankyou_msg ====================
mov rax, 0
mov rdi, thankyou_msg
call printf

; =============== xrstor ================================
mov rax, 7
mov rdx, 0
xrstor [backuparea]

mov rax, num_array

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
