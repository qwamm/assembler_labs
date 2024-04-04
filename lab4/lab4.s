bits	64
;	Compare logarithm from matlib and my own implementation
section .data
msg1:
	db	"Input x", 10, 0
msg2:
	db	"%lf", 0
msg3:
	db	"ln(%.10g)=%.10g", 10, 0
msg4:
	db	"myln(%.10g)=%.10g", 10, 0
section .text
one	dq	1.0
n_one dq -1.0
myln:
	movsd	xmm1, [one] ;x
	movsd	xmm2, [n_one]  ;-1
	movsd	xmm3, [one] ;n
	movsd	xmm4, [one] ;result
	movsd	xmm5, [one] ;intermediate reslt
m0:
	mulsd xmm2, [n_one]
	mulsd xmm1, xmm1
	movsd xmm5, xmm1
	mulsd xmm5, xmm2
	divsd xmm5, xmm3
	addsd xmm4, xmm5
	dec r10
	cmp r10, 0
	jne m0
	movsd xmm0, xmm4
	ret
x equ 2
y equ x + 1
extern printf
extern scanf
extern log
global main
main:
	push rbp
	mov rbp, rsp
	sub rsp, y
	mov edi, msg1
	xor eax, eax
	call printf
	leave
	xor eax, eax
	ret
