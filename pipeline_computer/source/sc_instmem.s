main:addi $1, $0, 128
addi $2, $0, 132
addi $3, $0, 136
addi $7, $0, 140
addi $8, $0, 1
add_loop:lw $8, 0($7)
lw $4, 0($1)
lw $5, 0($2)
add $6, $4, $5
sw $4, 0($1)
sw $5, 0($2)
sw $6, 0($3)
beq $8, $0, and_loop
add $0, $0, $0
j add_loop
add $0, $0, $0
and_loop:lw $4, 0($1)
lw $5, 0($2)
and $6, $4, $5
sw $4, 0($1)
sw $5, 0($2)
sw $6, 0($3)
j and_loop
add $0, $0, $0