bits    64
;       Sorting columns of matrix by max elements
section .data
n:
        dq      3
m:
        dq      5
matrix_1:
        dq      4, 6, 1, 8, 2
        dq      9, 2, 3, 4, 5
        dq      0, -7, 3, -1, -1
matrix_2:
        dq      0, 0, 0, 0, 0
        dq      0, 0, 0, 0, 0
        dq      0, 0, 0, 0, 0

sum:
        dq      0, 0, 0, 0, 0
adress:
	dq	0, 1, 2, 3, 4
section .text
global  _start
_start:
        mov     rcx, [m]
        cmp     rcx, 1
        jle     m13
        mov     rbx, matrix_1
	mov rdi, 0
	mov rsi, matrix_1
	l1:
		mov [adress + 8*rdi], rsi
		add rsi, 8
		inc rdi
		loop l1
	mov rcx, [m]
        xor rdi, rdi
        xor rsi, rsi
m1:
	mov rax, [rbx]
	mov rcx, [n]
	dec rcx
	test rcx, rcx
	jz m13
	mov rdi, 0
m2:
	mov rcx, [n]
	dec rcx
	mov rax, [matrix_1 + rdi*8]
	mov r9, rdi
        mov rdx, [m]
    	add rdx, rdi
m3:
	mov rbx, [matrix_1 + rdx*8]
	add rdx, [m]
	add rax, rbx
	mov [sum + rdi*8], rax
	loop m3
	add rdi, 1
	cmp [m], rdi
	jne m2
        mov rcx, [m]
        sub rcx, 1
m4:
	xor rsi,rsi
	mov rdi, [m]
	sub rdi, rcx
	mov rax, [sum + 8*rdi]
	mov rdx, rdi
	dec rdx
m5:
	cmp rdx, rsi
	js m8
	je m8
	mov r10, rdx
	add r10, rsi
	shr r10, 1
	cmp [sum + 8*r10], rax
	js m7
	je m7
	jmp m6

m6:
	mov rdx, r10
	jmp m5

m7:
	inc r10
	mov rsi, r10
	jmp m5

m8:
        mov r10, rcx
        mov rdx, rsi
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
        mov rdx, [adress + r8*8 - 8]
        mov [adress + r8*8], rdx
	dec r8
	loop m9
m10:
	mov rcx, r10
	mov [sum + 8*rsi], rax
	mov [adress + 8*rsi], r9
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
	mov rcx, [m]
	mov rdi, 0
	l2:
        	mov rax, [sum + 8*rdi]
        	inc rdi
       		loop l2
m12:
	mov rax, 60
	mov rbx, 0
	syscall
m13:
	mov rax, 60
	mov rbx, 1
	syscall
