.section .text
.global _start
_start:
    la sp, stack
    li a0, 65536
    csrr a1, mhartid
    addi a1, a1, 1
    mul a0, a0, a1
    add sp, sp, a0
    call kstart
kdone:
	li t0, 268435456       # place address of uart0
    la t1, kdone_str
    li t2, 0               # index into string
    li t3, '.'             # the period at the end of "returned from kstart." string
kdone_print:
    add a0, t1, t2         # get our address for our access into the string
    lb a0, 0(a0)           # load from our offest
    sb a0, 0(t0)           # write the loaded byte to the UART
    beq a0, t3, kdone_loop # if we have reached the end, jump to the infinite spinloop
    addi t2, t2, 1         # increment string index
    j kdone_print
kdone_loop:
    wfi
    j kdone_loop

.section .data
    .globl stack
    .align 16
stack:
    .zero 65536

.section .rodata
kdone_str:
    .asciz "returned from kstart."
