bits 64
section .data:
n:
	dq 3
conv_matrix:
	dq -1, -1, -1
	dq -1, 8, -1
	dq -1, -1, -1

section .text

global compute_pixel_value
compute_pixel_value:
	add rdi, rsi
	mov rax, rdi
	ret
