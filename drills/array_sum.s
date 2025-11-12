.data
my_array:
    .word 10 ,20 ,30 ,40 ,50

.text
.global _start
_start:
    li t0 , 0#sum_container
    la t1 , my_array#pointer(0)
    li t2 , 0#pointer_num
    li t3 , 5#loop_times
    li t4 , 0#count
loop:
    beq t4 , t3 ,end_loop
    lw t2 , 0(t1)
    add t1 , t1 ,4
    add t0 ,t0,t2
    add t4 , t4 , 1
    j loop

end_loop:
    mv a0 , t0
    li a7 , 93
    ecall




