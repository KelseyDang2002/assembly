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
  miles_msg db "For how many miles will you maintain this average speed: ", 0
  miles_msg_len equ $-miles_msg
  final_seg_msg db "What will be your speed during the final segment of the trip (mph): ", 0
  final_seg_msg_len equ $-final_seg_msg
  avg_speed_msg db "Your average speed will be %1.18lf mph.", 10, 0
  avg_speed_msg_len equ $-avg_speed_msg
  total_msg db "The total travel time will be %1.18lf hours.", 10, 0
  total_msg_len equ $-total_msg
  floatform db "%lf", 0
  hotel_distance dq 253.5

section .text
las_vegas:                ; start here

  ; Prompt for input of initial distance
  mov rax, 0              ; rax counts number of float register
  mov rdi, initial_msg
  call printf
  ; End of block

  ; Get initial from user
  mov rax, 0
  mov rdi, floatform
  push qword 0            ; push to top of stack
  mov rsi, rsp
  call scanf
  movsd xmm8, [rsp]       ; dereference rsp and copy to xmm8
  pop rax                 ; restore stack
  ; End of block

  ; Prompt for input of miles maintained
  mov rax, 0
  mov rdi, miles_msg
  call printf
  ; End of block

  ; Get miles from user
  mov rax, 0
  mov rdi, floatform
  push qword 0
  mov rsi, rsp
  call scanf
  movsd xmm9, [rsp]
  pop rax
  ; End of block

  ; Prompt for input of final speed
  mov rax, 0
  mov rdi, final_seg_msg
  call printf
  ; End of block

  ; Get final_seg from user
  mov rax, 0
  mov rdi, floatform
  push qword 0
  mov rsi, rsp
  call scanf
  movsd xmm10, [rsp]
  pop rax
  ; End of block

  ; Block to copy 25.3 into xmm1
  movsd xmm1, qword [hotel_distance]

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
