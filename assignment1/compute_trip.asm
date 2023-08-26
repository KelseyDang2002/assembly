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
  initial_msg db "Please enter the speed for the initial segment of the trip (mph): ", 0
  initial_msg_len equ $-initial_msg

  initial_output db "Initial entered: %1.18lf", 10, 0
  initial_output_len equ $-initial_output

  miles_msg db "For how many miles will you maintain this average speed: ", 0
  miles_msg_len equ $-miles_msg

  miles_output db "Miles maintained entered: ", 10, 0
  miles_output_len equ $-miles_output

  final_seg_msg db "What will be your speed during the final segment of the trip (mph): ", 0
  final_seg_msg_len equ $-final_seg_msg

  final_output db "Final speed entered: ", 10, 0
  final_output_len equ $-final_output

  avg_speed_msg db "Your average speed will be %1.18lf mph.", 10, 0
  avg_speed_msg_len equ $-avg_speed_msg

  total_msg db "The total travel time will be %1.18lf hours.", 10, 0
  total_msg_len equ $-total_msg

  floatform db "%lf", 0
  stringform db "%s", 0
  hotel_distance dq 253.5
  three dq 3.0

section .bss
  align 64
  backuparea resb 832

section .text
las_vegas:                ; start here

  ; Backup GPRs
  ; push rbp
  ; mov rbp, rsp
  ; push rbx
  ; push rcx
  ; push rdx
  ; push rsi
  ; push rdi
  ; push r8
  ; push r9
  ; push r10
  ; push r11
  ; push r12
  ; push r13
  ; push r14
  ; push r15
  ; pushf

  ; Prompt for input of initial distance
  push qword 0
  mov qword rax, 0
  mov rdi, stringform     ; "%s"
  mov rsi, initial_msg
  call printf
  pop rax
  ; End of block

  ; Get initial from user
  push qword 0            ; push to top of stack
  mov qword rax, 0
  mov rdi, floatform      ; "%lf"
  mov rsi, rsp
  call scanf
  movsd xmm8, [rsp]       ; dereference rsp and copy to xmm8
  pop rax                 ; restore stack
  ; End of block

  ; Print initial from user
  mov rax, 0
  mov rsi, initial_output
  call printf
  ; End of block

  ; Prompt for input of miles maintained
  mov qword rax, 0
  mov rdi, stringform     ; "%s"
  mov rsi, miles_msg
  call printf
  ; End of block

  ; Get miles from user
  push qword 0
  mov qword rax, 0
  mov rdi, floatform
  mov rsi, rsp
  call scanf
  movsd xmm9, [rsp]
  pop rax
  ; End of block

  ; Print miles from user
  mov rax, 0
  mov rsi, miles_output
  call printf
  ; End of block

  ; Prompt for input of final speed
  mov qword rax, 0
  mov rdi, stringform     ; "%s"
  mov rsi, final_seg_msg
  call printf
  ; End of block

  ; Get final_seg from user
  push qword 0
  mov qword rax, 0
  mov rdi, floatform
  mov rsi, rsp
  call scanf
  movsd xmm10, [rsp]
  pop rax
  ; End of block

  ; Print final_seg from user
  mov rax, 0
  mov rsi, final_output
  call printf
  ; End of block

  ; Block to copy 253.5 into xmm1 and 3.0 into xmm2
  movsd xmm1, qword [hotel_distance]
  movsd xmm2, qword [three]

  ; Output avg_speed_msg
  mov rax, 0
  mov rdi, avg_speed_msg
  call printf
  ; End of block

  ; Output total travel time
  mov rax, 0
  mov rdi, total_msg
  call printf
  ; End of block

  ; Block to set return value
  push r14
  movsd xmm0, [rsp]
  pop r14

  ; Restore GPRs
  ; popf
  ; pop r15
  ; pop r14
  ; pop r13
  ; pop r12
  ; pop r11
  ; pop r10
  ; pop r9
  ; pop r8
  ; pop rdi
  ; pop rsi
  ; pop rdx
  ; pop rcx
  ; pop rbx
  ; pop rbp

  ret
