; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Section: 240-3

global output_array
extern cpuid
extern fgets
extern strlen
extern atoi
extern stdin
extern stdout
extern printf

segment .data
labels db "output_array: IEEE754              Scientific Decimal", 10, 0
data_format db "output_array: 0x%016lx = %-.7E", 10, 0
delay db "output_array: delay = %lf", 10, 0

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
mov rax, 7
mov rdx, 0
xsave [backuparea]

; =============== output_array ==========================

xor r13, r13            ; index starting at 0
mov r14, rdi            ; num_array
mov r15, rsi            ; size of num_array
mov r12, rdx            ; frequency * delay

; print label
mov rax, 0
mov rdi, labels
mov rsi, stringform
call printf

; read clock and put into r10
xor rax, rax
xor rdx, rdx
cpuid
rdtsc
shl rdx, 32
or rax, rdx
mov r10, rax

; add r10 to r12
add r12, r10

beginloop:
  cmp r13, r15          ; if index reaches size of num_array
  jge endloop           ; jump to end of loop

  mov rax, 1
  mov rdi, data_format
  mov rsi, [r14+8*r13]
  movsd xmm0, [r14+8*r13]
  call printf
  inc r13
  jmp beginloop

  ; read clock and put into r11
  xor rax, rax
  xor rdx, rdx
  cpuid
  rdtsc
  shl rdx, 32
  or rax, rdx
  mov r11, rax

  ; compare r11 with r12
  cmp r11, r12
  jg endloop

endloop:

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
