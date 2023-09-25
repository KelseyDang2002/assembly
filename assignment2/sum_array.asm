; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/25/23
; Subject: CPSC 240-03 Assignment 2 Arrays
; Filename: sum_array.asm

global sum_array

segment .data

segment .bss

segment .text
sum_array:

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
; mov rax, 7
; mov rdx, 0
; xsave [backuparea]

; Block

; =============== xrstor ================================
; mov rax, 7
; mov rdx, 0
; xrstor [backuparea]

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
