; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/25/23
; Subject: CPSC 240-03 Assignment 2 Arrays
; Filename: manage.asm

global manage
extern fill_array
extern sum_array
extern output_array
extern printf
extern scanf
max_size equ 8

segment .data
welcome_msg db "We will take care of all your array needs.", 10, 0

input_msg db "Please input float numbers followed by ws. After the last number, press ws followed by CTRL + D: ", 10, 0

receive_input_msg db "Thank you. The numbers in the array are: ", 10, 0

sum_msg db "The sum of the numbers in the array is %lf", 10, 0

end_msg db "Thank you for using Array Management System.", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
array resq max_size ; array is a number where cell 0 starts in memory

segment .text
manage:

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

; =============== Print welcome_msg =====================
mov rax, 0
mov rdi, stringform
mov rsi, welcome_msg
call printf

; =============== Print input_msg =======================
mov rax, 0
mov rdi, stringform
mov rsi, input_msg
call printf

; =============== Call fill_array =======================
mov rax, 0
mov rdi, array
mov rsi, max_size
call fill_array

; =============== Print receive_input_msg ===============
mov rax, 0
mov rdi, stringform
mov rsi, receive_input_msg
call printf

; =============== Call output_array =====================

; =============== Call sum_array ========================

; =============== Print sum_msg =========================
mov rax, 0
mov rdi, stringform
mov rsi, sum_msg
call printf

; =============== Print end_msg =========================
mov rax, 0
mov rdi, stringform
mov rsi, end_msg
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

ret
