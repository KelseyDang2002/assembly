; Program Name: Random Numbers
; Subject: CPSC 240-03 <Strings>
; This program demonstrates non-deterministic random number generation.

; Copyright (C) 2023 Kelsey Dang

; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
; License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it
; will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
; PARTICULAR PURPOSE.  See the GNU General Public License for more details.  A copy of the GNU General Public
; License v3 is available here:  <https://www.gnu.org/licenses/>.

; Author Information
;   Author: Kelsey Dang
;   Email: kdangdo2002@csu.fullerton.edu
;
; Program Information
;   Program Name: Random Numbers
;   Program Languages: C, Assembly X86-64, bash
;   Due Date: ---
;   Operating System: Tuffix VM on Windows 10 computer

; Purpose
;   This file gets called by executive.asm and prints the array in IEEE754 and scientific decimal.

; File Information
;   Filename: show_array.asm
;   Language: Assembly X86-64
;   Compile: nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm
;   Link: gcc -m64 -fno-pie -no-pie -std=c17 -o a.out main.o executive.o fill_random_array.o show_array.o isnan.o

global show_array
extern printf

segment .data
labels db "show_array: IEEE754                Scientific Decimal", 10, 0
data_format db "show_array: 0x%016lx     %-18.13g", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832

segment .text
show_array:

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

; =============== show_array ============================
xor r13, r13            ; index starting at 0
mov r14, rdi            ; num_array
mov r15, rsi            ; size of num_array

; print label
mov rax, 0
mov rdi, labels
mov rsi, stringform
call printf

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
