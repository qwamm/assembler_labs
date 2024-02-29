section .data
	a dd 1
	a_len equ $-a
	b dw 1
	b_len equ $-b
	c dd 1
	c_len equ $-c
	d dw 1
	d_len equ $-d
	e dd 4
	e_len equ $-e

section .text
	global _start

_start:
	mov eax, 3
	mov ebx, 1
	lea ecx, [a]
	mov edx, a_len
	int 0x80
	mov eax, 3
	mov ebx, 1
	lea ecx, [b]
	mov edx, b_len
	int 0x80
        mov eax, 3
        mov ebx, 1
        lea ecx, [c]
        mov edx, c_len
        int 0x80
        mov eax, 3
        mov ebx, 1
        lea ecx, [d]
        mov edx, d_len
        int 0x80
        mov eax, 3
        mov ebx, 1
        lea ecx, [e]
        mov edx, e_len
        int 0x80
	mov eax, dword [a]
	movzx ebx, word [b]
	sub eax, '0'
	sub ebx, '0'
	mul ebx
	add eax, '0'
	add ebx, '0'
	mov dword [a], eax
	int 0x80
        mov eax, 4
        mov ebx, 1
        mov ecx, a
        mov edx, 1
	int 0x80
	mov eax, 1
	int 0x80
