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
wrong dq -1.0

segment .bss
align 64
backuparea resb 832

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
; xmm10-xmm15 does not lose data
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
movsd xmm13, [rsp]        ; first speed in xmm13

; Check for invaild input
; xorpd xmm9, xmm9
; ucomisd xmm8, xmm9
; jb invalid_input
; jmp first_leg
;
; invalid_input:
; mov rax, 0
; mov rdi, stringform
; mov rsi, invalid_msg
; call printf
; movsd xmm0, [wrong]
; jmp done
; End of block

; =============== First leg ===================================

first_leg:
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
movsd xmm14, [rsp]        ; first leg in xmm14

; Check for invaild input
; xorpd xmm9, xmm9
; ucomisd xmm10, xmm9
; jb invalid_input2
; jmp second_speed
;
; invalid_input2:
; mov rax, 0
; mov rdi, stringform
; mov rsi, invalid_msg
; call printf
; movsd xmm0, [wrong]
; jmp done
; End of block

; ================= Second speed =============================

second_speed:
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
movsd xmm15, [rsp]        ; second speed in xmm15
; End of block

; ================= Second leg = 253.5 - first leg ===========
; xmm13 = first_speed
; xmm14 = first_leg
; xmm15 = second_speed
movsd xmm12, [hotel_distance]       ; xmm12 = 253.5
subsd xmm12, xmm14                  ; xmm12 = xmm12 - xmm14, xmm12 = second_leg

; ================= Average total speed =======================
; xmm13 = first_speed
; xmm14 = first_leg
; xmm15 = second_speed
; xmm12 = second_leg
divsd xmm14, xmm13                  ; xmm14 = first_leg / first_speed
divsd xmm12, xmm15                  ; xmm12 = second_leg / second_speed
addsd xmm12, xmm14                  ; xmm12 = xmm12 + xmm14, xmm12 = average total time

; ================= Average speed ==============================
; xmm14 = first_leg / first_speed
; xmm12 = average total time
movsd xmm14, [hotel_distance]       ; xmm14 = 253.5
divsd xmm14, xmm12                  ; xmm14 = xmm14 / xmm12, xmm14 = average speed

; ============= Output avg_speed_msg ============================
movsd xmm0, xmm14
mov rax, 1
mov rdi, avg_speed_msg
call printf

; ============= Output total travel time ========================
movsd xmm0, xmm12
mov rax, 1
mov rdi, total_msg
call printf
; End of block

; Call to main.cpp
movsd xmm0, xmm12

; =============== Restore GPRs ==========================
done:
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
