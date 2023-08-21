; Name: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/4/23
; Subject: CPSC 240-03 Assignment 1
; Filename: compute_trip.asm

global _start

section .data
  ; constants
  message: db "Hello World!", 0xA
  message_length: equ $-message

section .text
  _start:                   ; start here
    mov rax, 0x1            ; use the write syscall
    mov rdi, 0x1            ; use stdout as the file descriptor
    mov rsi, message        ; use the message as the buffer
    mov rdx, message_length ; and supply the message
    SYSCALL                 ; invoke the syscall

    ; exit program
    mov rax, 0x3C
    mov rdi, 0x0
    SYSCALL
