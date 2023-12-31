; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 9/25/23
; Subject: CPSC 240-03 Assignment 2 Arrays
; Filename: fill_array.asm
; Purpose: This file gets user input of floats in the array.

global fill_array
extern printf
extern scanf

segment .data
debug_msg db "%lf entered", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832

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

; =============== xsave =================================
mov rax, 8
mov rdx, 0
xsave [backuparea]

; =============== Backup r14 and r15 ====================
pop rax               ; fixed a seg fault
mov r14, rdi          ; r14 is the array
mov r15, rsi          ; r15 is the number of cells
mov r13, 0            ; r13 is the starting index 0

; =============== Fill array ============================
xor r13, r13          ; r13 is the starting index 0

beginloop:
cmp r13, r15          ; if current index is >= number of cells (r15)
je endloop            ; end the loop

; =============== Receive input from user ===============
mov rax, 0
mov rdi, floatform    ; %lf
push qword 0          ; push 0 before calling scanf or seg fault
mov rsi, rsp
call scanf

cdqe                  ; convert doubleword to quadword for rax
cmp rax, -1           ; check for CTRL + D
je endloop            ; jump to end of loop if CTRL + D

pop rbx
mov [r14+8*r13], rbx
inc r13               ; r13++
jmp beginloop         ; start loop again

endloop:
mov rax, r13

; =============== xrstor ================================
; mov rax, 8
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
