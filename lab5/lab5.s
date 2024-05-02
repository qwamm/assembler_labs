bits 64
section .data:
n:
	dq 3
conv_matrix:
	dq -1, -1, -1
	dq -1, 8, -1
	dq -1, -1, -1

section .text

global compute_pixel
compute_pixel:
	sub rsi, rdi
	mov rax, rsi
	ret
