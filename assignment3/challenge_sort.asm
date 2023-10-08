; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/1/23
; Subject: CPSC 240-03 Assignment 3 <Sort by Pointers>
; Filename: challenge_sort.asm
; Purpose: This file sorts the elements in the array.

global challenge_sort
extern printf

segment .data
debug_msg db "challenge_sort: called", 10, 0

stringform db "%s", 0

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

; =============== xsave =================================
; mov rax, 10
; mov rdx, 0
; xsave [backuparea]

; =============== test call =============================
mov rax, 0
mov rdi, stringform
mov rsi, debug_msg
call printf

; =============== Backup r14 and r15 ====================
mov r14, rdi          ; r14 is the array
mov r15, rsi          ; r15 is the size of the array
mov r13, -1           ; index for outter loop (step)
mov r12, 0            ; index for inner loop (i)

; =============== challenge_sort ========================
; outerloop:
; inc r13               ; r13 is now index 0
; cmp r13, r15          ; compare index and size of array
; jge endloop           ; end loop if index >= size of array
;
; mov r12, 0            ; resets counter of inner loop (i)
; jmp innerloop         ; continue to inner loop
;
;   innerloop:
;   mov r11, r15        ; copy r15 (size) into r11
;   sub r11, r13        ; r11 is size - step (r15 - r13)
;   cmp r11, r12        ; compare i with (size - step)
;   jge outerloop
;
;   lea r10, [r14+8*r12]; **array[i]
;   movsd xmm15, [r10]
;   lea r9, [r14+16*r12]; **array[i + 1]
;   movsd xmm14, [r9]
;   inc r12
;   ucomisd xmm15, xmm14
;   jge swap
;
;   swap:
;   mov r8, r12
;   sub r8, 1
;   lea [r14+16*r8], xmm15
;   lea [r14+8*r8], xmm14
;   jmp innerloop
;
; endloop:
; mov rax, r14

; =============== xrstor ================================
; mov rax, 10
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
