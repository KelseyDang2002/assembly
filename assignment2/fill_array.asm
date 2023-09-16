; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/25/23
; Subject: CPSC 240-03 Assignment 2 Arrays
; Filename: fill_array.asm

global fill_array
extern printf
extern scanf

segment .data
input_msg db "Please input float numbers followed by ws. After the last number, press ws followed by CTRL + D: ", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss

segment .text
fill_array:

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

; ============== Print input_msg ===============
mov rax, 0
mov rdi, stringform
mov rsi, input_msg
call printf

; ============== Fill array ====================

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
