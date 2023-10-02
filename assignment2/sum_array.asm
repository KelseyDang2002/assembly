; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 9/25/23
; Subject: CPSC 240-03 Assignment 2 Arrays
; Filename: sum_array.asm
; Purpose: This file adds all the floats in the array and sends it to manage.

global sum_array
extern printf

segment .data
test_msg db 10, "sum_array", 10, 0

stringform db "%s", 0

segment .bss
align 64
backuparea resb 832

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
mov rax, 8
mov rdx, 0
xsave [backuparea]

; =============== Backup r14 and r15 ====================
mov r14, rdi          ; r14 is the array
mov r15, rsi          ; r15 is the number of cells
mov r13, 0            ; r13 is the starting index 0

; =============== Sum of elements in array ==============
xor r13, r13          ; r13 is the starting index 0

beginloop:
cmp r13, r15          ; if current index is >= number of cells (r15)
je endloop            ; end the loop

addsd xmm15, [r14+8*r13]

inc r13
jmp beginloop

endloop:
movsd xmm0, xmm15

; =============== xrstor ================================
mov rax, 8
mov rdx, 0
xrstor [backuparea]

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
