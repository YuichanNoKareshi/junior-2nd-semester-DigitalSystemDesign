main:addi $1, $0, 128
addi $2, $0, 132
addi $3, $0, 136
add_loop:lw $4, 0($1)
lw $5, 0($2)
add $6, $4, $5
sw $4, 0($1)
sw $5, 0($2)
sw $6, 0($3)
j add_loop
add $0, $0, $0