main:addi $1, $0, 128
addi $2, $0, 132
addi $3, $0, 136
addi $7, $0, 140
addi $8, $0, 144
addi $9, $0, 1
last_add:beq $9, $0, start_and
add $0, $0, $0
bne $9, $0, start_add
add $0, $0, $0
last_and:bne $9, $0, start_and
add $0, $0, $0
start_add:lw $9, 0($7)
lw $4, 0($1)
lw $5, 0($2)
add $6, $4, $5
sw $4, 0($1)
sw $5, 0($2)
sw $6, 0($3)
j last_add
add $0, $0, $0
start_and:lw $9, 0($8)
lw $4, 0($1)
lw $5, 0($2)
and $6, $4, $5
sw $4, 0($1)
sw $5, 0($2)
sw $6, 0($3)
j last_and
add $0, $0, $0