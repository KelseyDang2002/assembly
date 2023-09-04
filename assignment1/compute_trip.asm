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

distance: resq 1

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
; push qword 0
mov rax, 0
mov rdi, stringform       ; "%s"
mov rsi, initial_msg
call printf

; Get initial from user
; push qword 0
mov rax, 0
mov rdi, floatform        ; "%lf"
mov rsi, rsp
call scanf
movsd xmm8, [rsp]         ; initial speed input in xmm8 now
; movsd qword [first_speed], xmm8
; pop rax

; Print initial from user
; push qword 0
mov rax, 1
mov rdi, debug
call printf
; End of block

; =============== First leg ===================================

; Prompt for input of miles maintained
; push qword 0
mov rax, 0
mov rdi, stringform       ; "%s"
mov rsi, miles_msg
call printf

; Get miles from user
; push qword 0
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf
movsd xmm9, [rsp]         ; miles input in xmm9 now
; movsd qword [first_leg], xmm9
; pop rax

; Print miles from user
; push qword 0
mov rax, 1
mov rdi, debug
call printf
; End of block

; ================= Second speed =============================

; Prompt for input of final speed
; push qword 0
mov rax, 0
mov rdi, stringform       ; "%s"
mov rsi, final_seg_msg
call printf

; Get final_seg from user
; push qword 0
mov rax, 0
mov rdi, floatform
mov rsi, rsp
call scanf
movsd xmm10, [rsp]        ; final_seg input in xmm10 now
; movsd qword [second_speed], xmm10
; pop rax

; Print final_seg from user
; push qword 0
mov rax, 1
mov rdi, debug
call printf
; pop rax
; End of block

; ================= First leg / first speed ==================
; xmm8 = initial (first speed)
; xmm9 = miles (first leg)
movsd xmm11, xmm9
divsd xmm11, xmm8
movsd xmm12, xmm11
; movsd xmm11, qword [first_leg]          ; move first_speed (xmm8) into xmm11
; divsd xmm11, qword [first_speed]        ; xmm11 = xmm11 / first_speed
; movsd qword [first_time], xmm11         ; move xmm11 into first_time

; ================= Second leg = 253.5 - first leg ===========
movsd xmm11, qword [hotel_distance] ; xmm11 = 253.5
movsd xmm15, xmm11       ; copy xmm11 into xmm15, xmm15 = 253.5
subsd xmm11, xmm9        ; xmm11 = xmm11 - xmm9 (second leg = 253.5 - first leg)

; ============= Second leg / second speed =======================
; xmm10 = second speed
; xmm14 = second leg
divsd xmm11, xmm10        ; xmm11 = xmm11 / xmm10
; movsd qword [second_time], xmm11

; ============= Total travel time ===============================
; total travel time = (first leg / first speed) + (second leg / second speed)
; movsd xmm11, qword [second_time]
addsd xmm11, xmm12
; addsd xmm9, xmm14         ; total travel time
; movsd xmm13, xmm9         ; copy total travel time into xmm13

; ============= Average speed ===================================
; average speed = 253.5 / total travel time
divsd xmm15, xmm11 ; xmm15 = xmm15 / xmm11 (average speed = 253.5 / total travel time)

; ============= Output avg_speed_msg ============================
; movsd xmm15, [rsp] ; move average speed to top of stack
; push qword 0
mov rax, 1
movsd xmm0, xmm15
movsd xmm0, [rsp]
mov rdi, avg_speed_msg
call printf
; mov qword rax, 0
; pop rax

; ============= Output total travel time ========================
; movsd xmm0, xmm11        ; move total travel time to top of stack
; push qword 0
mov rax, 1
movsd xmm0, xmm11
movsd xmm0, [rsp]
mov rdi, total_msg
call printf
; mov qword rax, 0
; pop rax
; End of block

; ============= Calculate average speed =========================
; hotel_distance = 253.5
; xmm8 = initial (first speed) DONE
; xmm9 = miles (first leg) DONE
; xmm10 = final_seg (second leg) DONE
; second_leg = 253.5 - first leg DONE
; total travel time = (first leg / first speed) + (second leg / second speed)
; average speed = 253.5 / total travel time

; Set return value
; setreturnvalue:
; push r14
movsd xmm0, [rsp]
; pop r14

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
