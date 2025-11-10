# task1_2.s: A program to perform a simple subtraction.

.section .text
.globl _start

_start:
    li t0 , 6 #loop times
    li t1 , 0 #sum
    li t2 , 1 #sum_num
loop:
    beq t2 , t0 , end_loop 
    add t1 , t1 , t2
    addi t2 , t2 , 1
    j loop

end_loop:
    mv a0 , t1
    li a7, 93       # a7 = 93 (exit service)
    ecall
