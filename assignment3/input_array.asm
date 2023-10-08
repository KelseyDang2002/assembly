; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/1/23
; Subject: CPSC 240-03 Assignment 3 <Sort by Pointers>
; Filename: input_array.asm
; Purpose: This file gets user input of floats in the array.

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
je endloop            ; jump to ned of loop if CTRL + D

mov [r14+8*r13], r12
inc r13               ; increment r13 (i++)
jmp beginloop         ; start loop again

endloop:

; =============== xrstor ================================
mov rax, 10
mov rdx, 0
xrstor [backuparea]

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
