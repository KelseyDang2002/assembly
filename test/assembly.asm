global assembly
extern printf
extern scanf

segment .data
msg db "assembly: World", 10, 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss

segment .text
assembly:

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

; =============== Print msg =============================
mov rax, 0
mov rdi, stringform
mov rsi, msg
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
