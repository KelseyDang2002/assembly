; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/25/23
; Subject: CPSC 240-03 Assignment 2 Arrays
; Filename: output_array.asm

global output_array
extern printf

segment .data
print_data db "output_array: %16.10lf", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832

segment .text
output_array:

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

; =============== Backup r14 and r15 ====================
mov r14, rdi          ; r14 is the array
mov r15, rsi          ; r15 is the number of cells

; =============== Display the array =====================
xor r13, r13          ; r13 is the starting index 0

beginloop:
cmp r13, r15          ; if current index is >= number of cells (r15)
je endloop            ; end the loop

; =============== Print data in array ===================
movsd xmm0, [r14+8*r13]
mov rax, 1
mov rdi, print_data
call printf

inc r13
jmp beginloop

endloop:
mov rax, r13

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
