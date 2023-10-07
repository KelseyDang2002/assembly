; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/1/23
; Subject: CPSC 240-03 Assignment 3 <Sort by Pointers>
; Filename: challenge_sort.asm
; Purpose: This file sorts the elements in the array.

global challenge_sort

segment .data

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

; =============== Backup r14 and r15 ====================
mov r14, rdi          ; r14 is the array
mov r15, rsi          ; r15 is the size of the array
mov r13, -1           ; index for outter loop (step)
mov r12, 0            ; index for inner loop (i)

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
