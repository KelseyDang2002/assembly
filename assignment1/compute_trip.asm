; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/4/23
; Subject: CPSC 240-03 Assignment 1 Las Vegas Problem
; Filename: compute_trip.asm

global las_vegas
extern printf
extern scanf

section .data
  ; Constants
  prompt db "Please enter the speed for the initial segment of the trip (mph): ", 0
  prompt_len equ $-prompt
  floatform db "%lf", 0

section .text
las_vegas:                ; start here
  ; Prompt for input of initial distance
  mov rax, 0              ; rax counts number of float register
  mov rdi, prompt
  call printf
  ; End of block

  ; Get float number from user
  mov rax, 0
  mov rdi, floatform
  push qword 0            ; push to top of stack
  mov rsi, rsp
  call scanf
  movsd xmm8, [rsp]       ; dereference rsp and copy to xmm8
  pop rax                 ; restore stack
  ; End of block
