   # dot_product_recursive.s
.data
    a: .word 1, 2, 3, 4, 5 # a
    b: .word 6, 7, 8, 9, 10 # b
    newline: .string "\n" # newline

.text
main:
    la a0, a # loading address of a to a. Consider this as passing value.
    
    la a1, b # loading address of b to a1. Consider this as passing value.
    
    addi a2, zero, 5 # size = 5
    
    jal dot_product
    
    # assume that the function follow the convention
    # the returning value or result must be store at a0

    # print
    mv a1, a0
    addi a0, zero, 1
    ecall
    
    j exit
    
exit:
    # newline
    la a1, newline
    addi a0, zero, 4
    ecall

    # exit
    addi a0, zero, 10
    ecall
    
    
dot_product:
    # Value registrations
    # t0 = 1 // the temporary setup for if condition
    # t1 = a[0]
    # t2 = b[0]
    # t3 = a[0] * b[0]
    # Arguments
    # a0 - int *a // address of a
    # a1 - int *b // address of b
    # a2 - size // size of array
    # According to the convention, 
    # the result must be return using a0

    lw t1, 0(a0) # t1 value of a[0]
    lw t2, 0(a1) # t2 value of b[0]
    mul t3, t1, t2 # t3 = a[0] * b[0]
    
    li t0, 1 # set 1 for the following condition
    beq a2, t0, exit_base_case # if size(a2) == 1, jump to the exit base case

    addi sp, sp, -8 # reserve 2 pos in stack
    sw ra, 0(sp) # save returning value to the reserved position in stack
    sw t3, 4(sp) # save t3 to the reserved position in stack

    addi a0, a0, 4 # a + 1 for recursion
    addi a1, a1, 4 # b + 1 for recursion
    addi a2, a2, -1 # size - 1 for recursion
    
    jal dot_product

    lw t3, 4(sp) # load t3 from stack
    add a0, t3, a0 # t3(a[0]*b[0]) + a0(result of the previous level recursion)

    lw ra, 0(sp) # load ra from stack to restore main's return address

    addi sp, sp, 8 # free space in stack

    jr ra # return
    
exit_base_case:
    mv a0, t3
    jr ra