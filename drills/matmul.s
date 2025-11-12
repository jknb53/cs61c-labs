# ====================================================================
#  matmul.s - The Stack-Based Final Solution
#  This is the ONLY correct solution for this specific, broken environment
#  because the linker/QEMU ignores CFLAGS and places all static writable
#  data (.data, .bss) at the illegal address 0. The stack is the only
#  safe, writable memory available at runtime.
# ====================================================================

.section .text
.globl _start

_start:
    # We MUST jump over the read-only data definitions.
    j main_logic

# --- Read-Only Data (Safely embedded in .text section) ---
.align 4
A:
    .word 1, 2, 3, 4
B:
    .word 5, 6, 7, 8

main_logic:
    # --- STACK SETUP for Matrix C ---
    # Allocate 16 bytes on the stack for our 2x2 C matrix.
    addi sp, sp, -16

    # --- Initialization ---
    la s3, A          # Base address of A (from read-only .text)
    la s4, B          # Base address of B (from read-only .text)
    mv s5, sp         # Base address of C is now the top of our stack space
    li s0, 0          # i = 0
    li t1, 2          # N = 2

loop_i:
    bge s0, t1, end_loop_i

    li s1, 0          # j = 0
loop_j:
    bge s1, t1, end_loop_j

    li t0, 0          # sum = 0
    li s2, 0          # k = 0
loop_k:
    bge s2, t1, end_loop_k

    # --- Calculations ---
    mul s6, s0, t1; add s6, s6, s2; slli s6, s6, 2; add s6, s3, s6; lw s9, 0(s6)
    mul s7, s2, t1; add s7, s7, s1; slli s7, s7, 2; add s7, s4, s7; lw s10, 0(s7)
    mul t4, s9, s10
    add t0, t0, t4

    addi s2, s2, 1      # k++
    j loop_k

end_loop_k:
    # --- Store Sum to C on the STACK ---
    mul s8, s0, t1; add s8, s8, s1; slli s8, s8, 2; add s8, s5, s8; sw t0, 0(s8)

    addi s1, s1, 1      # j++
    j loop_j

end_loop_j:
    addi s0, s0, 1      # i++
    j loop_i

end_loop_i:
    # --- Final Verification from the STACK ---
    addi t6, s5, 12     # Address of C[1][1] on the stack
    lw a0, 0(t6)

    # --- STACK CLEANUP ---
    # Good practice: Restore the stack pointer before exiting.
    addi sp, sp, 16

    li a7, 93
    ecall
    