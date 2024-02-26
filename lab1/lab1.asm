section .data
	msg db 'Hello, World!', 0

section .text
	global main

main:
	mov rax, 
	mov ebx, 1
	lea ecx, [msg]
	mov edx, 13
	int 0x80

	mov eax, 1
	int 0x80
