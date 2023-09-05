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

; distance: resq 1

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
mov rsi, first_speed
call scanf

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
mov rsi, first_leg
call scanf

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
; push qword 0
mov rax, 0
mov rdi, floatform
mov rsi, second_speed
call scanf
; pop rax

; Print final_seg from user
; mov rax, 1
; mov rdi, debug
; call printf
; End of block

; ================= Move variables into xmm registers ==============
movsd xmm8, qword [first_speed]
movsd xmm9, qword [first_leg]
movsd xmm10, qword [second_speed]

; ================= First leg / first speed ==================
; xmm8 = first speed
; xmm9 = first leg
; movsd xmm11, xmm9             ; copy first_leg into xmm11
divsd xmm9, xmm8                ; xmm9 = xmm9 / xmm8
movsd qword [first_time], xmm9  ; copy xmm9 into first_time variable for later use

mov rax, 1
mov rdi, debug
call printf

; ================= Second leg = 253.5 - first leg ===========
movsd xmm11, qword [hotel_distance] ; xmm11 = 253.5
; movsd xmm15, xmm11          ; copy xmm11 into xmm15 for later use
movsd xmm9, qword [first_leg]
subsd xmm11, xmm9           ; xmm11 = xmm11 - xmm9 (xmm11 = second leg)

; ============= Second leg / second speed =======================
; xmm10 = second speed
; xmm11 = second leg
divsd xmm11, xmm10          ; xmm11 = xmm11 / xmm10 (second_leg / second_speed)
movsd qword [second_time], xmm11 ; copy xmm11 into second_time variable for later use

; ============= Total travel time ===============================
; total travel time = (first leg / first speed) + (second leg / second speed)
; total travel time = first_time + second_time
; xmm9 = first_time
; xmm11 = second_time
addsd xmm11, xmm9           ; xmm11 = xmm11 + xmm9 (total travel time)
movsd qword [total_time], xmm11 ; copy xmm11 into total_time variable for output

; ============= Average speed ===================================
; average speed = 253.5 / total travel time
; xmm11 = total travel time
movsd xmm12, qword [hotel_distance]
divsd xmm12, xmm11          ; xmm12 = xmm12 / xmm11 (average speed)
movsd qword [avg_speed], xmm12 ; copy xmm12 into avg_speed variable for output

; ============= Output avg_speed_msg ============================
mov rax, 1
mov rdi, avg_speed_msg
movsd xmm1, qword [avg_speed]
call printf

; ============= Output total travel time ========================
; push qword 0
mov rax, 1
mov rdi, total_msg
movsd xmm0, qword [total_time]
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
