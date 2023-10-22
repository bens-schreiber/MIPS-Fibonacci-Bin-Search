.data
array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
array_size: .word 10
newline: .asciiz "\n"
input_prompt: .asciiz "Enter an integer to search for: "
not_found_msg: .asciiz "The integer was not found in the array.\n"
found_msg: .asciiz "The integer was found at index "

.text
.globl main
main:
    # Print the input prompt and read in the target integer
    li $v0, 4
    la $a0, input_prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    
    # Load the address of the array into $t1
    la $t1, array
    
    # Load the size of the array into $t2
    lw $t2, array_size
    
    # Initialize $t3 to 0 (the index of the first element)
    li $t3, 0
    
    # Initialize $t4 to the index of the last element
    addi $t4, $t2, -1
    
    # Loop until the search is complete
    binary_search_loop:
        # If $t3 > $t4, the search is complete and the integer was not found
        bgt $t3, $t4, integer_not_found
        
        # Calculate the midpoint of the search range
        add $t5, $t3, $t4
        sra $t5, $t5, 1
        
        # Load the value at the midpoint into $t6
        sll $t7, $t5, 2
        add $t7, $t1, $t7
        lw $t6, ($t7)
        
        # If the target integer is less than the midpoint, search the left half
        blt $t0, $t6, binary_search_left
        
        # If the target integer is greater than the midpoint, search the right half
        bgt $t0, $t6, binary_search_right
        
        # If the target integer is equal to the midpoint, the search is complete and the integer was found
        li $v0, 4
        la $a0, found_msg
        syscall
        move $a0, $t5
        li $v0, 1
        syscall
        j end_program
        
    binary_search_left:
        # Set $t4 to the index of the element to the left of the midpoint
        addi $t4, $t5, -1
        j binary_search_loop
        
    binary_search_right:
        # Set $t3 to the index of the element to the right of the midpoint
        addi $t3, $t5, 1
        j binary_search_loop
        
    integer_not_found:
        # Print a message indicating that the integer was not found
        li $v0, 4
        la $a0, not_found_msg
        syscall
        
    end_program:
        # Exit the program
        li $v0, 10
        syscall