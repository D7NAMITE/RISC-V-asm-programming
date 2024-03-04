.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
printline: .string "The dot product is:"
newline: .string "\n"

.text
main:
# USABLE Registers: x5 - x9, x18 - x31
addi x5, zero, 0 # int sop = 0

# for (i = 0; i < 5; i++) {
#         sop += a[i] * b[i];
#     }
addi x6, zero, 0 # int i = 0
addi x7, zero, 5 # create a temporary 5

loop:
    bge x6, x7, exit # if i >= 5 jump to exit
    slli x8, x6, 2 # set x8 to i*4: index
    la x9, a # loading address of a to x9
    add x9, x9, x8 # cut to the value in a[i]
    lw x18, 0(x9) # x18 = a[i]
    la x19, b # loading address of a to x19
    add x19, x19, x8 # cut to the value in a[i]
    lw x20, 0(x19) # x20 = a[i]
    mul x22, x18, x20 # a[i] * b[i]
    add x5, x5, x22 # sop += a[i] * b[i]
    addi x6, x6, 1 # i++
    j loop
    
exit:
# print "The dot product is:"
    addi a0, zero, 4
    la a1, printline
    ecall
    
# newline
    addi a0, zero, 4
    la a1, newline
    ecall

# print sop
    addi a0, zero, 1
    add a1, zero, x5
    ecall
    
# exit code
    addi a0, zero, 10
    ecall