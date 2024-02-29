section .data
	a: dd 4
	a_len: equ $-a
	b: dw 2
	b_len: equ $-b
	c: dd 1
	c_len: equ $-c
	d: dw 0
	d_len: equ $-d
	e: dd 2
	e_len: equ $-e
	res: dd 0
	res_len: equ $-res

section .text
	global _start

_start:
	mov eax, dword [c]
	movzx ebx, word [d]
	mov ecx, dword[e]
	mul ebx
	jc error
	mul ecx
	jc error
	mov dword[res], eax
	mov eax, dword [a]
	movzx ebx, word [b]
	mov ecx, dword[c]
	mul ebx
	jc error
	mul ecx
	jc error
	mov ebx, dword[res]
	sub eax,ebx
	jc error
	mov dword[res], eax
	mov eax, dword [a]
	movzx ebx, word [b]
	test ebx, ebx
	jz error
	div ebx
	mov dword[e], eax
	mov eax, dword [c]
	movzx ebx, word [d]
	test ebx, ebx
	jz error
	div ebx
	mov ebx, dword[e]
	add eax, ebx
	jc error
	mov ebx, eax
	mov eax, dword[res]
	div ebx
	add eax, '0'
	mov dword[res], eax
	int 0x80
        mov eax, 4
        mov ebx, 1
        lea ecx, [res]
        mov edx, res_len
	int 0x80
	mov eax, 1
	mov ebx, 0
	int 0x80

error:
	mov ebx, 1
	mov eax, 1
	int 0x80

