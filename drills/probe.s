.data
TEST_DATA:
    .word 99
.section .text
.globl _start
_start:
    la t0, TEST_DATA
    lw t1, 0(t0)
    mv a0, t1
    li a7, 93
    ecall
    