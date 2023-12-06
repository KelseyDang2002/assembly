; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Section: 240-3

global input_array
extern rdrand
extern printf

segment .data
fill_msg db 10, "input_array: The array has been filled with random numbers.", 10, 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832

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
mov rax, 7
mov rdx, 0
xsave [backuparea]

; =============== output_array ==========================
xor r13, r13            ; index starting at 0
mov r14, rdi            ; num_array
mov r15, rsi            ; size of num_array

beginloop:
  cmp r13, r15          ; if index reaches size of num_array
  jge endloop           ; jump to end of loop

  rdrand r12            ; generate random number and copy to r15
  mov [r14+8*r13], r12
  inc r13               ; i++
  jmp beginloop         ; jump to beginloop until index = size

endloop:
; =============== Print fill_msg ========================
mov rax, 0
mov rdi, fill_msg
call printf

; =============== xrstor ================================
mov rax, 7
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
