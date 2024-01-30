.section .text
.global _start
_start:
kdone:
	li t0, 268435456 # place address of uart0
    la t1, kdone_str
    li t2, 0
kdone_print:
    add a0, t1, t2
    lb a0, 0(a0)
    sb a0, 0(t0)
    addi t2, t2, 1
    j kdone_print
kdone_loop:
    wfi
    j kdone_loop

.section .rodata
kdone_str:
    .asciz "returned from kernel."
    