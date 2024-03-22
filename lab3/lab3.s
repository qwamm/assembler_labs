bits 64

section .data
	file_name dd "/home/qurst/assembler_labs/lab3/in.txt"
	;msg db "Welcome to Tutorials Point"
	;msg_len equ  $-msg
	consonants db "aeiouAEIOU"
	con_len equ $-consonants
	n db 0

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
	;mov [n], rax

	mov rdi, str
	;dec rdi
	mov rcx, str_len
	mov rdx, new_str

m1:
        cmp byte [rdi], 10
        je m5
	mov r10, rcx
	mov r9, rdi
        l1:
		mov al, byte [rdi]
		mov ecx, con_len
		mov edi, consonants
		cld
		repne scasb
		je m6
		mov [rdx], al
		inc rdx
		mov rcx, r10
		mov rdi, r9
		jmp m2

m2:
	inc rdi
	cmp byte [rdi], ' '
	je m3
   	cmp byte [rdi], 10
   	je m5
   	movzx r8, byte [rdi]
	mov [rdx], r8
	inc rdx
	loop m2

m3:
        cmp byte [rdi], ' '
        jne m7
        cmp byte [rdi], 10
        je m5
	movzx r8, byte [rdi]
	mov [rdx], r8
        inc rdi
        inc rdx
	loop m3

m4:
        inc rdi
        cmp byte [rdi], ' '
        je m3
        cmp byte [rdi], 10
        je m5
        loop m4

m5:
	;new_str output
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

m6:
                mov rcx, r10
                mov rdi, r9
                jmp m4

m7:
	;movzx r8, byte [rdi]
        ;mov [rdx], r8
	;inc rdx
	;inc rdi
	jmp m1
