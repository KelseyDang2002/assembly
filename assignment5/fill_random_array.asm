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
