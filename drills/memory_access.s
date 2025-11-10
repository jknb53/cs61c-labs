.data
my_array:
    .word 5 , 10 , 15

.text
.global _start
    _start:
    # ld t0 , my_array
    la t0 , my_array
    lw t1 , 4(t0)
    lw t2 , 8(t0)
    add t1 , t1 , t2
    sw t1 ,0(t0)
    #mv a0 ,t1
    add a0 , t1 , 0

    li a7, 93 
    ecall
