; Author: Kelsey Dang
; Email: kdangdo2002@csu.fullerton.edu
; Due Date: 10/4/23
; Subject: CPSC 240-03 Assignment 1 Las Vegas Problem
; Filename: compute_trip.asm

global las_vegas
extern printf
extern scanf

segment .data
; Constants
initial_msg db "    Please enter the speed for the initial segment of the trip (mph): ", 0
initial_msg_len equ $-initial_msg

miles_msg db "    For how many miles will you maintain this average speed: ", 0
miles_msg_len equ $-miles_msg

final_seg_msg db "    What will be your speed during the final segment of the trip (mph): ", 0
final_seg_msg_len equ $-final_seg_msg

avg_speed_msg db "    Your average speed will be %1.5lf mph.", 10, 0
avg_speed_msg_len equ $-avg_speed_msg

total_msg db "    The total travel time will be %1.2lf hours.", 10, 0
total_msg_len equ $-total_msg

invalid_msg db "    Invalid number. Try again.", 10, 0
invalid_msg_len equ $-invalid_msg

debug db "    Debug: %1.2lf", 10, 10, 0
debug_len equ $-debug

floatform db "%lf", 0
stringform db "%s", 0
hotel_distance dq 253.5

segment .bss
align 64
backuparea resb 832

first_speed: resq 1
first_leg: resq 1
first_time: resq 1

second_speed: resq 1
second_leg: resq 1
second_time: resq 1

avg_speed: resq 1
total_time: resq 1

segment .text
las_vegas:                ; start here

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

; =============== First speed ================================

; Prompt for input of initial distance
mov rax, 0
mov rdi, stringform       ; "%s"
mov rsi, initial_msg
call printf

; Get initial from user
mov rax, 0
mov rdi, floatform        ; "%lf"
mov rsi, rsp
call scanf
movsd xmm8, [rsp]

; Print initial from user
; mov rax, 1
; mov rdi, debug
; call printf
; End of block

; =============== First leg ===================================

; Prompt for input of miles maintained
mov rax, 0
mov rdi, stringform       ; "%s"
mov rsi, miles_msg
call printf

; Get miles from user
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf
movsd xmm9, [rsp]

; Print miles from user
; mov rax, 1
; mov rdi, debug
; call printf
; End of block

; ================= Second speed =============================

; Prompt for input of final speed
mov rax, 0
mov rdi, stringform       ; "%s"
mov rsi, final_seg_msg
call printf

; Get final_seg from user
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf
movsd xmm10, [rsp]

; Print final_seg from user
; mov rax, 1
; mov rdi, debug
; call printf
; End of block

; ================= Move variables into xmm registers ==============
; movsd xmm8, qword [first_speed]
; movsd xmm9, qword [first_leg]
; movsd xmm10, qword [second_speed]

; ================= First leg / first speed ==================
; xmm8 = first speed
; xmm9 = first leg
; xmm10 = second_speed
movsd xmm11, xmm9                 ; copy xmm9 into xmm11 for later use
divsd xmm9, xmm8                  ; xmm9 = xmm9 / xmm8 (xmm9 = first_time)
; movsd xmm13, qword [hotel_distance] ; xmm13 = 253.5
; subsd xmm13, xmm9               ; xmm13 = xmm13 / xmm9 (xmm13 = second_leg)
; divsd xmm13, xmm10              ; xmm13 = xmm13 / xmm10 (xmm13 = second_time)
; divsd xmm9, xmm8                ; xmm9 = xmm9 / xmm8 (xmm9 = first_time)
; addsd xmm13, xmm9               ; xmm13 = xmm13 + xmm9 (total travel time = second_time + first_time)
; addsd xmm8, xmm10
; divsd xmm13, xmm8

; ================= Second leg = 253.5 - first leg ===========
movsd xmm12, qword [hotel_distance] ; xmm12 = 253.5
movsd xmm13, xmm12                ; copy xmm12 into xmm13 for later use
subsd xmm12, xmm11                ; xmm12 = xmm12 - xmm11 (xmm12 = second leg)
; movsd xmm9, qword [first_leg]

; ============= Second leg / second speed =======================
; xmm10 = second speed
; xmm12 = second leg
divsd xmm12, xmm10                ; xmm12 = xmm12 / xmm10 (xmm12 = second_time)
; movsd qword [second_time], xmm11 ; copy xmm11 into second_time variable for later use

; ============= Total travel time ===============================
; total travel time = (first leg / first speed) + (second leg / second speed)
; total travel time = first_time + second_time
; xmm9 = first_time
; xmm12 = second_time
addsd xmm12, xmm9                 ; xmm12 = xmm12 + xmm9 (total travel time)
; movsd qword [total_time], xmm11 ; copy xmm11 into total_time variable for output

; ============= Average speed ===================================
; average speed = 253.5 / total travel time
; xmm12 = total travel time
; xmm13 = 253.5
; movsd xmm12, qword [hotel_distance]
divsd xmm13, xmm12                ; xmm13 = xmm13 / xmm12 (xmm13 = average speed)
; movsd xmm12, qword [hotel_distance]
; movsd qword [avg_speed], xmm12 ; copy xmm12 into avg_speed variable for output

; ============= Output avg_speed_msg ============================
movsd xmm0, xmm13
mov rax, 1
mov rdi, avg_speed_msg
call printf

; ============= Output total travel time ========================
movsd xmm0, xmm12
mov rax, 1
mov rdi, total_msg
call printf
; End of block

; Set return value
movsd xmm0, [rsp]

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
