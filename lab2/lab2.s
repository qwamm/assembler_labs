bits    64
;       Sorting columns of matrix by max elements
section .data
n:
        dq      3
m:
        dq      5
matrix:
        dq      4, 6, 1, 8, 2
        dq      9, 2, 3, 4, 5
        dq      0, -7, 3, -1, -1
sum:
        dq      0, 0, 0, 0, 0
section .text
global  _start
_start:
        mov     rcx, [m]
        cmp     rcx, 1
        jle     m11
        mov     rbx, matrix
        xor rdi, rdi
        xor rsi, rsi
m1:
	mov rax, [rbx]
	mov rcx, [n]
	dec rcx
	test rcx, rcx
	jz m11
	mov rdi, 0
m2:
	mov rcx, [n]
	dec rcx
	mov rax, [matrix + rdi*8]
        mov rdx, [m]
    	add rdx, rdi
m3:
	mov rbx, [matrix + rdx*8]
	add rdx, [m]
	add rax, rbx
	mov [sum + rdi*8], rax
	loop m3
	add rdi, 1
	cmp [m], rdi
	jne m2
        mov rcx, [m]
        sub rcx, 2
m4:
	xor rsi,rsi
	mov rdi, [m]
	dec rdi
	sub rdi, rcx
	mov rax, [sum + 8*rdi]
	mov rdx, rdi
	dec rdx
m5:
	cmp rdx, rsi
	jz m8
	mov r10, rdi
	sub r10, rsi
	shr r10, 1
	add r10, rsi
	cmp [sum + 8*r10], rax
	jz m6
	jnz m7

m6:
	mov rdx, r10
	jmp m5

m7:
	add r10, 1
	mov rsi, r10
	jmp m5

m8:
        mov r10, rcx
        mov rdx, rsi
	add rdx, 1
	mov rbx, rdi
	sub rbx, rdx
	mov rcx, rbx
	mov r8, rdi
m9:
	test rcx, rcx
	js m10
	jz m10
	mov rdx, [sum + r8*8 - 8]
	mov [sum + r8*8], rdx
	dec r8
	loop m9
m10:
	mov rcx, r10
	mov [sum + 8*rsi], rax
	inc rdi
	dec rcx
	test rcx, rcx
	jnz m4
	mov rcx, [m]
	mov rdi, 0
m11:
	mov rax, [sum + 8*rdi]
	inc rdi
	loop m11
m12:
	mov rax, 60
	mov rbx, 1
	syscall
