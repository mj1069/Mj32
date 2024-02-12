; assembler code
; use customasm to run the assembler (open source assembler programming tool)
; github link: https://hlorenzi.github.io/customasm
; refer risc-v version 2.2 for instructions
; girhub link: https://github.com/riscv/riscv-isa-manual/releases/tag/Ratified-IMAFDQC

; 32 bit register file of RISC V
#ruledef register{
	x0 => 0b00000
	x1 => 0b00001
	x2 => 0b00010
	x3 => 0b00011
	x4 => 0b00100
	x5 => 0b00101
	x6 => 0b00110
	x7 => 0b00111
	x8 => 0b01000
	x9 => 0b01001
	x10 => 0b01010
	x11 => 0b01011
	x12 => 0b01100
	x13 => 0b01101
	x14 => 0b01110
	x15 => 0b01111
	x16 => 0b10000
	x17 => 0b10001
	x18 => 0b10010
	x19 => 0b10011
	x20 => 0b10100
	x21 => 0b10101
	x22 => 0b10110
	x23 => 0b10111
	x24 => 0b11000
	x25 => 0b11001
	x26 => 0b11010
	x27 => 0b11011
	x28 => 0b11100
	x29 => 0b11101
	x30 => 0b11110
	x31 => 0b11111
}

; Register type instructions
#ruledef{
	add 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b000 @ rs1 @rs2 @ 0b0000000
	sub 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b000 @ rs1 @rs2 @ 0b0100000
	sll 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b001 @ rs1 @rs2 @ 0b0000000
	slt 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b010 @ rs1 @rs2 @ 0b0000000
	sltu 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b011 @ rs1 @rs2 @ 0b0000000
	xor 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b100 @ rs1 @rs2 @ 0b0000000
	srl 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b101 @ rs1 @rs2 @ 0b0000000
	sra 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b101 @ rs1 @rs2 @ 0b0100000
	or 		{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b110 @ rs1 @rs2 @ 0b0000000
	and 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b111 @ rs1 @rs2 @ 0b0000000
	not 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b100 @ rs1 @rs2 @ 0b0100000
	inv 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0110011 @ rd @ 0b100 @ rs1 @rs2 @ 0b0100000

}

; example code for register type instructions
add x31, x0, x31
sub x31, x0, x31
sll x31, x0, x31
slt x31, x0, x31
sltu x31, x0, x31
xor x31, x0, x31
srl x31, x0, x31
sra x31, x0, x31
or x31, x0, x31
and x31, x0, x31
not x31, x0, x31
inv x31, x0, x31

; Immediate type instructions
#ruledef{
	jalr 	{rd: register}, {rs1: register}, {value: i12}  => 0b1100111 @ rd @ 0b000 @ rs1 @ value
	lb	 	{rd: register}, {rs1: register}, {value: i12}  => 0b0000011 @ rd @ 0b000 @ rs1 @ value
	lh	 	{rd: register}, {rs1: register}, {value: i12}  => 0b0000011 @ rd @ 0b000 @ rs1 @ value
	lw	 	{rd: register}, {rs1: register}, {value: i12}  => 0b0000011 @ rd @ 0b000 @ rs1 @ value
	lbu 	{rd: register}, {rs1: register}, {value: u12}  => 0b0000011 @ rd @ 0b000 @ rs1 @ value
	lhu 	{rd: register}, {rs1: register}, {value: u12}  => 0b0000011 @ rd @ 0b000 @ rs1 @ value
	addi 	{rd: register}, {rs1: register}, {value: i12}  => 0b0110011 @ rd @ 0b000 @ rs1 @ value
	slti 	{rd: register}, {rs1: register}, {value: i12}  => 0b0110011 @ rd @ 0b010 @ rs1 @ value
	sltiu 	{rd: register}, {rs1: register}, {value: u12}=> 0b0110011 @ rd @ 0b011 @ rs1 @ value
	xori 	{rd: register}, {rs1: register}, {value: i12}  => 0b0110011 @ rd @ 0b100 @ rs1 @ value
	ori 	{rd: register}, {rs1: register}, {value: i12}  => 0b0110011 @ rd @ 0b110 @ rs1 @ value
	andi 	{rd: register}, {rs1: register}, {value: i12}  => 0b0110011 @ rd @ 0b111 @ rs1 @ value
	slli 	{rd: register}, {rs1: register}, {value: i5}   => 0b0110011 @ rd @ 0b001 @ rs1 @ value @ 0b0100000
	srli 	{rd: register}, {rs1: register}, {value: i5}   => 0b0110011 @ rd @ 0b101 @ rs1 @ value @ 0b0000000
	srai 	{rd: register}, {rs1: register}, {value: i5}   => 0b0110011 @ rd @ 0b101 @ rs1 @ value @ 0b0100000

	mv	 	{rd: register}, {rs1: register} => 0b0110011 @ rd @ 0b000 @ rs1 @ 0b000000000000
	mvi 	{rd: register}, {value: i12}    => 0b0110011 @ rd @ 0b000 @ 0b00000 @ value

	nop => 0b0110011 @ 0b0000000000000000000000000

	seqz 	{rd: register}, {rs1: register}  => 0b0110011 @ rd @ 0b001 @ rs1 @ 0b000000000000
	snez 	{rd: register}, {rs1: register}  => 0b0110011 @ rd @ 0b001 @ rs1 @ 0b000000000000
	li	 	{rd: register}, {value: i12}     => 0b0110011 @ rd @ 0b000 @ value @ 0b00000

	jr 		{rd: register}   => 0b1100111 @ rd @ 0b000 @ 0b00000000000000000
}

; example coder for immediate type instruction
addi x31, x0, 100
jalr x31, x0, 10
lb x31, x0, 100
lh x31, x0, 100
lw x31, x0, 100
lbu x31, x0, 100
lhu x31, x0, 100
addi x31, x0, 10
slti x31, x0, 10
sltiu x31, x0, 10
xori x31, x0, 10
ori x31, x0, 10
andi x31, x0, 10
slli x31, x0, 10
srli x31, x0, 10
srai x31, x0, 10
mv x31, x0
mvi x31, 10
nop
seqz x31, x0
snez x31, x0
li x31, 10
jr x31

; Store type instructions
#ruledef{
	sb 	{rd: register}, {rs1: register}, {value: i12}  => 0b0100011 @ rd @ 0b000 @ rs1 @ value
	sh 	{rd: register}, {rs1: register}, {value: i12}  => 0b0100011 @ rd @ 0b001 @ rs1 @ value
	sw 	{rd: register}, {rs1: register}, {value: i12}  => 0b0100011 @ rd @ 0b010 @ rs1 @ value
}

; example coder for store type instructions
sb x31, x0, 100
sh x31, x0, 100
sw x31, x0, 100

; Load immediate type instruction (U type)
#ruledef{
	lui 	{rd: register}, {value: i20}  => 0b0110111 @ rd @ value
	auipc 	{rd: register}, {value: i20}  => 0b0010111 @ rd @ value
	la	 	{rd: register}, {value: i20}  => 0b0110111 @ rd @ value
}

; example coder for load immediate type instruction (U type)
lui x31, 0
auipc x31, 0
la x31, 0

; Jump type instructions
#ruledef{
	jal 	{rd: register}, {value: i20}  => 0b1101111 @ rd @ value
	j	 	{value: i20}  				  => 0b1101111@ 0b00000 @ value
}

; example coder for jump type instruction
jal x31, 10
j 101

; Branch type instructions
#ruledef{
	beq 	{rs1: register}, {rs2: register}, {value: i12}  => 0b1100011 @ rs1 @ 0b000 @ rs2 @ value
	bne 	{rs1: register}, {rs2: register}, {value: i12}  => 0b1100011 @ rs1 @ 0b001 @ rs2 @ value
	blt 	{rs1: register}, {rs2: register}, {value: i12}  => 0b1100011 @ rs1 @ 0b100 @ rs2 @ value
	bge 	{rs1: register}, {rs2: register}, {value: i12}  => 0b1100011 @ rs1 @ 0b101 @ rs2 @ value
	bltu 	{rs1: register}, {rs2: register}, {value: u12}  => 0b1100011 @ rs1 @ 0b110 @ rs2 @ value
	bgeu 	{rs1: register}, {rs2: register}, {value: u12}  => 0b1100011 @ rs1 @ 0b111 @ rs2 @ value

	beqz 	{rs1: register}, {value: i12}  => 0b1100011 @ rs1 @ 0b000 @ 0b00000 @ value
	bnez 	{rs1: register}, {value: i12}  => 0b1100011 @ rs1 @ 0b001 @ 0b00000 @ value
}

; example coder for branch type instructions
beq x31, x2, 20
bne x31, x2, 20
blt x31, x2, 20
bge x31, x2, 20
bltu x31, x2, 20
bgeu x31, x2, 20
beqz x31, 20
bnez x31, 20
