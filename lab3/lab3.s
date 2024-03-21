bits 64

section .data
	file_name dd "/home/fdfdas/assembler_labs/lab3/in.txt"
	msg db "Welcome to Tutorials Point"
	msg_len equ  $-msg
	consonants db "aeiou"
	con_len equ $-consonants

section .bss
	str: resb 1024
	str_len: equ $-str
	new_str: resb 1024
	fd_out: resd 1
	fd_in: resd 1

section .text
global _start
_start:
	;open the file for reading
	mov rax, 2
	mov rdi, file_name
	mov rsi, 0
	syscall

	mov  [fd_in], rax

	;read from file
	mov rax, 0
	mov rdi, [fd_in]
	mov rsi, str
	mov rdx, 1024
	syscall

	mov rdi, -1
	mov rcx, str_len

m1:
	inc rdi
        cmp byte [str + 2*rdi], -1
        je m5
	lea rax, [str + 2*rdi]
	mov r10, rcx
	mov r9, rdi
	mov rcx, con_len
	mov rdi, 0
        l1:
		cmp rax, [consonants + 2*rdi]
		je m4
		inc rdi
		loop l1
                mov rcx, r10
                mov rdi, r9
		mov [new_str + rdi], rax
		jmp m2

m2:
	inc rdi
	cmp byte [str + rdi], ' '
	je m3
        cmp byte [str + rdi], -1
        je m5
   mov r8, [str + rdi]
	mov [new_str + rdi], r8
	loop m2

m3:
   mov r8, [str + rdi]
	mov [new_str + rdi], r8
	inc rdi
	cmp byte [str + rdi], ' '
	jne m1
	cmp byte [str + rdi], -1
	je m5
	loop m3

m4:
        inc rdi
        cmp byte [str + rdi], ' '
        je m3
        cmp byte [str + rdi], -1
        je m5
        loop m2

m5:
	mov rax, 1
	mov rdi, 1
	lea rsi, [new_str]
	mov rdx, 1024
	syscall

        ;close the file
        mov rax, 6
        mov rdi, [fd_in]
        syscall

        mov rax, 60
        mov rdi, 0
        syscall
