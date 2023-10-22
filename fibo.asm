.data
prompt:     .asciiz "Enter the value of n: "
result:     .asciiz "The Fibonacci sequence up to n: "
newline:    .asciiz "\n"

.text
.globl main

main:
    # Print a prompt and read 'n' from the user
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t2, $v0         # Store 'n' in $t2

    # Base case (n == 0)
    beqz $t2, exit

    # Fibo starts with 0 and 1
    li $t0, 0             # F(0)
    li $t1, 1             # F(1)

    # Pprint the 
    li $v0, 4             # Print string syscall code
    la $a0, result
    syscall

    # Print the first Fibonacci number (F(0))
    li $v0, 1
    move $a0, $t0
    syscall

    # Print a space
    li $v0, 11
    li $a0, ' '
    syscall

    # Calculate and print the Fibonacci sequence
fib_loop:
    # Calculate the next Fibonacci number: F(n) = F(n-1) + F(n-2)
    add $t3, $t0, $t1

    # Print the next Fibonacci number
    li $v0, 1 
    move $a0, $t3
    syscall

    # Print a space
    li $v0, 11
    li $a0, ' '
    syscall

    move $t0, $t1         # $t0 = F(n-1)
    move $t1, $t3         # $t1 = F(n)

    # Check if we reach the end
    addi $t2, $t2, -1
    bnez $t2, fib_loop

    # Print a newline
    li $v0, 4             # Print string syscall code
    la $a0, newline
    syscall

exit:
    # Exit the program
    li $v0, 10
    syscall
