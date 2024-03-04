.data
arr1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
arr2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
newline: .string "\n"

.text
main:
# Registers NOT to be used x0 to x4 and x10 to x17; reason to be explain later
# Register that we can use x5  to x9 and x18 to x x31; reason to be explain later

# int size=10, i, sum1 = 0, sum2 = 0;
    addi x5, zero, 10 # int size(x5) = 10
    addi x6, zero, 0 # int sum1(x6) = 0
    addi x7, zero, 0 # int sum2(x7) = 0
    
# for(i = 0; i < size; i++)
#    arr1[i] = i + 1;
    addi x8, zero,0 # int i(x8) = 0
    la x9, arr1 # Loading the address of arr1 to x9 
loop1:
    bge x8, x5, exit1 # if i >= size jump to exit1
    # We need to calculate &arr1[i]
    # we need the base address of arr1
    # we add an offset od i*4 to the base offset
    # as we dealing with integer arr which has 4 bytes
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x9 # add i*4 to the base address of arr1 and put it to x19
    addi x20, x8, 1 # set x20 to i + 1
    sw x20, 0(x19) # arr1[i] = i + 1
    addi x8, x8, 1 # i++
    j loop1
    
exit1:
    
#     for(i = 0; i < size; i++)
#         arr2[i] = 2*i;
    addi x8, zero,0 # int i(x8) = 0
    la x21, arr2 # loading the address of arr2 to x21
    
loop2:
    bge x8, x5, exit2 # if i >= size jump to exit1
    # We need to calculate &arr2[i]
    # we need the base address of arr2 (we got from la above)
    # we add an offset od i*4 to the base offset
    # as we dealing with integer arr which has 4 bytes
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x21 # add i*4 to the base address of arr2 and put it to x19
    add x20, x8, x8 # set x20 to i+i or 2*i
    sw x20, 0(x19) # arr1[i] = i+i = 2*i
    addi x8, x8, 1 # i++
    j loop2

exit2:
# for(i = 0; i < size; i++) {
#         sum1 = sum1 + arr1[i];
#         sum2 = sum2 + arr2[i];
#     }
    addi x8, zero,0 # int i(x8) = 0    
loop3:
    bge x8, x5, exit3 # if i >= size jump to exit3
    # sum1 + arr1[i]
    # need &arr1[i]
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x9 # add i*4 to the base address of arr1 and put it to x19
    lw x20, 0(x19) # x20 = arr1[i]
    add x6, x6, x20 # sum1 = sum1 + arr1[i]
    
    # sum2 + arr2[i]
    add x19, x18, x21 # add i*4 to the base address of arr2 and put it to x19
    lw x20, 0(x19) # x20 = arr2[i]
    add x7, x7, x20 # sum2 = sum2 + arr2[i]
    
    addi x8, x8, 1 # i++
    j loop3 # jump to loop3
    
exit3:
    # print int sum1
    addi a0, zero, 1
    add a1, x0, x6
    ecall
    
    # print string new line
    addi a0, zero, 4
    la a1, newline
    ecall
    
    # print int sum2
    addi a0, zero, 1
    add a1, x0, x7
    ecall
    
    # print string new line
    addi a0, zero, 4
    la a1, newline
    ecall
    
    # exit code
    addi a0, zero, 10
    ecall
    
    