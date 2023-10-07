; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/1/23
; Subject: CPSC 240-03 Assignment 3 <Sort by Pointers>
; Filename: director.asm
; Purpose: This file calls input_array, output_array, and sortpointers in Sort by Pointers.
; Then director.asm gets called by the main.cpp.

global director
extern input_array
; extern output_array
; extern sortpointers
extern printf
max_size equ 10

segment .data
welcome_msg db "director: This program will sort all of your doubles.", 10, 0

instruction_msg1 db "director: Please enter flocating point numbers seperated by white space.", 10, 0

instruction_msg2 db "director: After the last numeric input, enter at least one more WS followed by CTRL + D:", 10, 0

thanks_msg db "director: Thank you. You entered these numbers:", 10, 10, 0

output_end_msg db 10, "director: End of output array.", 10, 10, 0

sorting_msg db "director: The array is now being sorted without moving any numbers...", 10, 0

output_sort_msg db "director: The data in the array are now ordered as follows:", 10, 10, 0

exit_msg db "director: The array will be sent back to the caller function.", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832
array resq max_size

segment .text
director:

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

; =============== Print welcome_msg =====================
mov rax, 0
mov rdi, stringform
mov rsi, welcome_msg
call printf

; =============== Print instruction_msg1 ================
mov rax, 0
mov rdi, stringform
mov rsi, instruction_msg1
call printf

; =============== Print instruction_msg2 ================
mov rax, 0
mov rdi, stringform
mov rsi, instruction_msg2
call printf

; =============== Call input_array ======================
mov rax, 0
mov rdi, array
mov rsi, max_size
call input_array
mov r14, rax ; r14 holds the number of values stored in array

; =============== Print thanks_msg ======================
mov rax, 0
mov rdi, stringform
mov rsi, thanks_msg
call printf

; =============== Call output_array =====================
; TODO

; =============== Print output_end_msg ==================
mov rax, 0
mov rdi, stringform
mov rsi, output_end_msg
call printf

; =============== Print sorting_msg =====================
mov rax, 0
mov rdi, stringform
mov rsi, sorting_msg
call printf

; =============== Call sortpointers =====================
; TODO

; =============== Print output_sort_msg =================
mov rax, 0
mov rdi, stringform
mov rsi, output_sort_msg
call printf

; =============== Call output_array =====================
; TODO

; =============== Print output_end_msg ==================
mov rax, 0
mov rdi, stringform
mov rsi, output_end_msg
call printf

; =============== Print exit_msg ========================
mov rax, 0
mov rdi, stringform
mov rsi, exit_msg
call printf

; =============== Return execution to driver ============
movsd xmm0, [rsp]

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
