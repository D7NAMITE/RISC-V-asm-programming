main:
    # pass the first argument to a0
    # pass the first argument to a1
    li a0, 110 # set a0 = a
    li a1, 500 # set a1 = b
    jal mult

    # print int
    mv a1, a0
    addi a0, x0, 1
    ecall
    
    # exit code
    addi a0, x0, 10
    ecall

mult:
    # base case
    # compare a1 with 1, if the two are equal you exit the mult function
    li s0, 1
    beq a1, s0, exit_base_case

    # recursive case
    addi sp, sp, -4
    sw ra, 0(sp) # storing the ra value on to the stack


    # a + mult(a, b-1);
    # save a0 and a1 on to the stack
    addi sp, sp, -8
    sw a0, 0(sp)
    sw a1, 4(sp)
    
    addi a1, a1, -1  # b - 1

    jal mult
    mv t1, a0
    lw a0, 0(sp)
    addi sp, sp, 4
    add a0, a0, t1
    lw ra, 0(sp)
    addi sp, sp, 4
    # by convention the return is stored a0
    # restore a0 and a1 on to the stack

    # exit from recursive case
    add a0, a0, t0 # where t0 is the result from mult(a, b-1)
    lw ra, 0(sp) # restore the ra value from the stack
    addi sp, sp, 4 # restore the stack pointer
    j exit_base_case

exit_base_case:
    jr ra