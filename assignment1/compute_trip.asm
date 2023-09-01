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
  initial_msg db "    Please enter the speed for the initial segment of the trip (mph): ", 0
  initial_msg_len equ $-initial_msg

  initial_output db "    Initial entered: %1.18lf ", 10, 10, 0
  initial_output_len equ $-initial_output

  miles_msg db "    For how many miles will you maintain this average speed: ", 0
  miles_msg_len equ $-miles_msg

  miles_output db "    Miles maintained entered: %1.18lf ", 10, 10, 0
  miles_output_len equ $-miles_output

  final_seg_msg db "    What will be your speed during the final segment of the trip (mph): ", 0
  final_seg_msg_len equ $-final_seg_msg

  final_output db "    Final speed entered: %1.18lf ", 10, 10, 0
  final_output_len equ $-final_output

  avg_speed_msg db "    Your average speed will be %1.18lf mph.", 10, 0
  avg_speed_msg_len equ $-avg_speed_msg

  total_msg db "    The total travel time will be %1.18lf hours.", 10, 0
  total_msg_len equ $-total_msg

  invalid_msg db "    Invalid number. Try again.", 10, 0
  invalid_msg_len equ $-invalid_msg

  floatform db "%lf", 0
  stringform db "%s", 0
  hotel_distance dq 253.5

section .bss
  align 64
  backuparea resb 832

section .text
las_vegas:                ; start here

  ; Backup GPRs
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

  ; Prompt for input of initial distance
  mov rax, 0
  mov rdi, stringform     ; "%s"
  mov rsi, initial_msg
  call printf
  ; End of block

  ; Get initial from user
  mov rax, 0
  mov rdi, floatform      ; "%lf"
  mov rsi, rsp
  call scanf
  movsd xmm8, [rsp]       ; initial speed input in xmm8 now
  ; End of block

  ; Print initial from user
  mov rax, 1
  mov rdi, initial_output
  call printf
  ; End of block

  ; Prompt for input of miles maintained
  mov rax, 0
  mov rdi, stringform     ; "%s"
  mov rsi, miles_msg
  call printf
  ; End of block

  ; Get miles from user
  mov rax, 0
  mov rdi, floatform
  mov rsi, rsp
  call scanf
  movsd xmm9, [rsp]       ; miles input in xmm9 now
  ; End of block

  ; Print miles from user
  mov rax, 1
  mov rdi, miles_output
  call printf
  ; End of block

  ; Prompt for input of final speed
  mov rax, 0
  mov rdi, stringform     ; "%s"
  mov rsi, final_seg_msg
  call printf
  ; End of block

  ; Get final_seg from user
  mov rax, 0
  mov rdi, floatform
  mov rsi, rsp
  call scanf
  movsd xmm10, [rsp] ; final_seg input in xmm10 now
  ; End of block

  ; Print final_seg from user
  mov rax, 1
  mov rdi, final_output
  call printf
  ; End of block

  ; Block to calculate average speed
  movsd xmm12, [rsp]
  movsd xmm12, xmm9      ; xmm12 = xmm9
  divsd xmm9, xmm8       ; xmm9 = xmm9 / xmm8, hours in xmm9 now
  movsd xmm11, qword [hotel_distance] ; xmm11 = 253.5
  subsd xmm11, xmm12     ; xmm11 = xmm11 - xmm9
  divsd xmm11, xmm10     ; xmm11 = xmm11 / xmm10
  movsd xmm13, qword [hotel_distance] ; xmm13 = 253.5
  addsd xmm9, xmm11      ; xmm9 = xmm9 + xmm11
  movsd xmm0, xmm9       ; xmm14 = xmm9
  ; End of block

  ; Output avg_speed_msg
  mov rax, 1
  mov rdi, avg_speed_msg
  call printf
  ; End of block

  ; Calculate total travel time
  divsd xmm13, xmm14

  ; Output total travel time
  mov rax, 1
  mov rdi, total_msg
  call printf
  ; End of block

  ; Set return value
setreturnvalue:
  movsd xmm0, [rsp]

  ; Restore GPRs
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
