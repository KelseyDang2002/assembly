; Program Name: Strings
; Subject: CPSC 240-03 <Strings>
; This program demonstrates string operations with fgets.

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
;   Program Name: Strings
;   Program Languages: C, Assembly X86-64, bash
;   Due Date: 11/12/23
;   Operating System: Tuffix VM on Windows 10 computer

; Purpose
;   This is the faraday file calls isfloat.asm in Strings.
;   This file gets called by ampere.c.

; File Information
;   Filename: faraday.asm
;   Language: Assembly X86-64
;   Compile: nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm
;   Link: gcc -m64 -fno-pie -no-pie -std=c17 -o a.out ampere.o faraday.o isfloat.o

global fill_random_array
extern rdrand

segment .data
floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832

segment .text
fill_random_array:

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

; =============== fill_random_array =====================
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
