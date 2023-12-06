; Program Name: Final
; Subject: CPSC 240-03 <Final>
; This program is for the Final Program Exam.
;
; Copyright (C) 2023 Kelsey Dang
;
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
; License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it
; will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
; PARTICULAR PURPOSE.  See the GNU General Public License for more details.  A copy of the GNU General Public
; License v3 is available here:  <https://www.gnu.org/licenses/>.
;
; Author Information
;   Author: Kelsey Dang
;   Email: kdangdo2002@csu.fullerton.edu
;
; Program Information
;   Program Name: Final
;   Program Languages: C, Assembly X86-64, bash
;   Due Date: 12/6/23
;   Operating System: Tuffix VM on Windows 10 computer
;
; Purpose
;   ---
;
; File Information
;   Filename: manager.asm
;   Language: Assembly X86-64
;   Compile: nasm -f elf64 -l manager.lis -o manager.o manager.asm
;   Link:

global manager
extern printf
extern scanf
max_size equ 60

segment .data
test_msg db "manager: World!", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
align 64
backuparea resb 832

segment .text
manager:

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

; test block
mov rax, 0
mov rdi, test_msg
mov rsi, stringform
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
