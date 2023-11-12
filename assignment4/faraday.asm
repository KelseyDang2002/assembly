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

global faraday
extern isfloat
extern fgets
extern strlen
extern atof
extern stdin
extern printf
max_size equ 60

segment .data
prompt_name db "faraday: Please enter your name: ", 0
prompt_title db "faraday: Please enter your title or profession: ", 0

welcome_msg db "faraday: We always welcome a(n) %s to our electrical lab.", 10, 0

prompt_volts db 10, "faraday: Please enter the voltage of the electrical system at your site (volts): ", 0
prompt_ohms db "faraday: Please enter the electrical resistance in the system at your site (ohms): ", 0
prompt_seconds db "faraday: Please enter the time your system was operating (seconds): ", 0

thankyou_msg_1 db 10, "faraday: Thank you %s. ", 0
thankyou_msg_2 db "We at Majestic are pleased to inform you that your system performed %.2lf joules of work.", 10, 0

congrats_msg_1 db 10, "faraday: Congratulations %s. Come back any time and make use of our software.", 10, 0
congrats_msg_2 db "Everyone with title %s is welcome to use our programs at a reduced price.", 10, 0

invalid_msg db "faraday: Invalid input. Please try again.", 10, 0
debug_msg db "faraday: Float entered: %lf", 10, 0

floatform db "%lf", 0
stringform db "%s", 0

segment .bss
name_array resb max_size
title_array resb max_size
voltage_array resb max_size
ohm_array resb max_size
time_array resb max_size

segment .text
faraday:

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

; =============== Print prompt_name =====================
mov rax, 0
mov rdi, stringform
mov rsi, prompt_name
call printf

; =============== Get name from user ====================
mov rax, 0
mov rdi, name_array
mov rsi, max_size
mov rdx, [stdin]
call fgets

; remove \n char
mov rax, 0
mov rdi, name_array
call strlen
mov byte[name_array+rax-1], byte 0

; =============== Print prompt_title ====================
mov rax, 0
mov rdi, prompt_title
mov rsi, stringform
call printf

; =============== Get title from user ===================
mov rax, 0
mov rdi, title_array
mov rsi, max_size
mov rdx, [stdin]
call fgets

; remove \n char
mov rax, 0
mov rdi, title_array
call strlen
mov byte[title_array+rax-1], byte 0

; =============== Print welcome_msg =====================
mov rax, 0
mov rdi, welcome_msg
mov rsi, title_array
call printf

; =============== begin_num =============================
begin_num:

; =============== Print prompt_volts ====================
mov rax, 0
mov rdi, prompt_volts
mov rsi, stringform
call printf

; =============== Get voltage from user =================
voltage_input:
  mov rax, 0
  mov rdi, voltage_array
  mov rsi, max_size
  mov rdx, [stdin]
  call fgets

  ; remove \n char
  mov rax, 0
  mov rdi, voltage_array
  call strlen
  mov byte[voltage_array+rax-1], byte 0

  ; check if input is valid
  mov rax, 0
  mov rdi, voltage_array
  call isfloat          ; rax holds 0 if false and non-0 if true
  cmp rax, 0
  je invalid

  ; input is valid
  mov rax, 0
  mov rdi, voltage_array
  call atof             ; convert # to xmm0
  movsd xmm12, xmm0

  ; print input
  ; mov rax, 1
  ; mov rdi, debug_msg
  ; movsd xmm0, xmm12
  ; call printf

; =============== Print prompt_ohms =====================
mov rax, 0
mov rdi, prompt_ohms
mov rsi, stringform
call printf

; =============== Get ohm from user =====================
ohm_input:
  mov rax, 0
  mov rdi, ohm_array
  mov rsi, max_size
  mov rdx, [stdin]
  call fgets

  ; remove \n char
  mov rax, 0
  mov rdi, ohm_array
  call strlen
  mov byte[ohm_array+rax-1], byte 0

  ; check if input is valid
  mov rax, 0
  mov rdi, ohm_array
  call isfloat          ; rax holds 0 if false and non-0 if true
  cmp rax, 0
  je invalid

  ; input is valid
  mov rax, 0
  mov rdi, ohm_array
  call atof             ; convert # to xmm0
  movsd xmm13, xmm0

  ; print input
  ; mov rax, 1
  ; mov rdi, debug_msg
  ; movsd xmm0, xmm13
  ; call printf

; =============== Print prompt_seconds ==================
mov rax, 0
mov rdi, prompt_seconds
mov rsi, stringform
call printf

; =============== Get time from user ====================
time_input:
  mov rax, 0
  mov rdi, time_array
  mov rsi, max_size
  mov rdx, [stdin]
  call fgets

  ; remove \n char
  mov rax, 0
  mov rdi, time_array
  call strlen
  mov byte[time_array+rax-1], byte 0

  ; check if input is valid
  mov rax, 0
  mov rdi, time_array
  call isfloat          ; rax holds 0 if false and non-0 if true
  cmp rax, 0
  je invalid

  ; input is valid
  mov rax, 0
  mov rdi, time_array
  call atof             ; convert # to xmm0
  movsd xmm14, xmm0

  ; print input
  ; mov rax, 1
  ; mov rdi, debug_msg
  ; movsd xmm0, xmm14
  ; call printf

; =============== Jump to continue if valid =============
jmp continue

; =============== Invalid input =========================
invalid:
mov rax, 0
mov rdi, invalid_msg
mov rsi, stringform
call printf
jmp begin_num

; =============== Continue ==============================
continue:

; =============== Calculate joules ======================
; =============== W = (V^2) * T / R =====================
; xmm12 = voltage
; xmm13 = ohm
; xmm14 = time
movsd xmm15, xmm12      ; copy voltage (xmm12) into xmm15
mulsd xmm15, xmm12      ; voltage (xmm15) * voltage (xmm12) = V^2

mulsd xmm15, xmm14      ; V^2 (xmm15) * T (xmm14)

divsd xmm15, xmm13      ; [(V^2) * T] / R (xmm13) = W (joules)

; =============== Print thankyou_msg_1 ==================
mov rax, 0
mov rdi, thankyou_msg_1
mov rsi, title_array
call printf

; =============== Print thankyou_msg_2 ==================
mov rax, 1
mov rdi, thankyou_msg_2
mov rsi, stringform
movsd xmm0, xmm15
call printf

; =============== Print congrats_msg_1 ==================
mov rax, 0
mov rdi, congrats_msg_1
mov rsi, name_array
call printf

; =============== Print congrats_msg_2 ==================
mov rax, 0
mov rdi, congrats_msg_2
mov rsi, title_array
call printf

; =============== Send joules to main ===================
movsd xmm0, xmm15

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
