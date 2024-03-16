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

#ruledef{
	add 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0000000 @ rs2 @ rs1 @ 0b000 @ rd @ 0b0110011
	sub 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0100000 @ rs2 @ rs1 @ 0b000 @ rd @ 0b0110011
	sll 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0000000 @ rs2 @ rs1 @ 0b001 @ rd @ 0b0110011
	slt 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0000000 @ rs2 @ rs1 @ 0b010 @ rd @ 0b0110011
	sltu 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0000000 @ rs2 @ rs1 @ 0b011 @ rd @ 0b0110011
	xor 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0000000 @ rs2 @ rs1 @ 0b100 @ rd @ 0b0110011
	srl 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0000000 @ rs2 @ rs1 @ 0b101 @ rd @ 0b0110011
	sra 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0100000 @ rs2 @ rs1 @ 0b101 @ rd @ 0b0110011
	or 		{rd: register}, {rs1: register}, {rs2: register}  => 0b0000000 @ rs2 @ rs1 @ 0b110 @ rd @ 0b0110011
	and 	{rd: register}, {rs1: register}, {rs2: register}  => 0b0000000 @ rs2 @ rs1 @ 0b111 @ rd @ 0b0110011

}

; Register type instructions

#ruledef{
	jalr 	{rd: register}, {rs1: register}, {value: i12}  => value @ rs1 @ 0b000 @ rd @ 0b1100111
	lb		{rd: register}, {rs1: register}, {value: i12}  => value @ rs1 @ 0b000 @ rd @ 0b0000011
	lh		{rd: register}, {rs1: register}, {value: i12}  => value @ rs1 @ 0b001 @ rd @ 0b0000011
	lw		{rd: register}, {rs1: register}, {value: i12}  => value @ rs1 @ 0b010 @ rd @ 0b0000011
	lbu 	{rd: register}, {rs1: register}, {value: u12}  => value @ rs1 @ 0b100 @ rd @ 0b0000011
	lhu 	{rd: register}, {rs1: register}, {value: u12}  => value @ rs1 @ 0b101 @ rd @ 0b0000011
	addi 	{rd: register}, {rs1: register}, {value: i12}  => value @ rs1 @ 0b000 @ rd @ 0b0010011
	slti 	{rd: register}, {rs1: register}, {value: i12}  => value @ rs1 @ 0b010 @ rd @ 0b0010011
	sltiu 	{rd: register}, {rs1: register}, {value: u12}  => value @ rs1 @ 0b011 @ rd @ 0b0010011
	xori 	{rd: register}, {rs1: register}, {value: i12}  => value @ rs1 @ 0b100 @ rd @ 0b0010011
	ori 	{rd: register}, {rs1: register}, {value: i12}  => value @ rs1 @ 0b110 @ rd @ 0b0010011
	andi 	{rd: register}, {rs1: register}, {value: i12}  => value @ rs1 @ 0b111 @ rd @ 0b0010011
	slli 	{rd: register}, {rs1: register}, {value: i5}   => 0b0000000 @ value @ rs1 @ 0b001 @ rd @ 0b0110011
	srli 	{rd: register}, {rs1: register}, {value: i5}   => 0b0000000 @ value @ rs1 @ 0b101 @ rd @ 0b0110011
	srai 	{rd: register}, {rs1: register}, {value: i5}   => 0b0100000 @ value @ rs1 @ 0b101 @ rd @ 0b0110011
}

; Immediate type instructions

#ruledef{
	sb 	{rs1: register}, {rs2: register}, {value: i12}  => value[11:5] @ rs2 @ rs1 @ 0b000 @ value[4:0] @ 0b0100011
	sh 	{rs1: register}, {rs2: register}, {value: i12}  => value[11:5] @ rs2 @ rs1 @ 0b001 @ value[4:0] @ 0b0100011
	sw 	{rs1: register}, {rs2: register}, {value: i12}  => value[11:5] @ rs2 @ rs1 @ 0b010 @ value[4:0] @ 0b0100011
}

; Store type instructions

#ruledef{
	lui		{rd: register}, {value: i20}  => value @ rd @ 0b0110111
	auipc 	{rd: register}, {value: i20}  => value @ rd @ 0b0010111
}

; Load immediate type instruction (U type)

#ruledef{
	jal 	{rd: register}, {value: i20}  => value @ rd @ 0b1101111
}

; Jump type instructions

#ruledef{
	beq 	{rs1: register}, {rs2: register}, {value: i12}  => value[11:5] @ rs2 @ rs1 @ 0b000 @ value[4:0] @ 0b1100011
	bne 	{rs1: register}, {rs2: register}, {value: i12}  => value[11:5] @ rs2 @ rs1 @ 0b001 @ value[4:0] @ 0b1100011
	blt 	{rs1: register}, {rs2: register}, {value: i12}  => value[11:5] @ rs2 @ rs1 @ 0b100 @ value[4:0] @ 0b1100011
	bge 	{rs1: register}, {rs2: register}, {value: i12}  => value[11:5] @ rs2 @ rs1 @ 0b101 @ value[4:0] @ 0b1100011
	bltu 	{rs1: register}, {rs2: register}, {value: u12}  => value[11:5] @ rs2 @ rs1 @ 0b110 @ value[4:0] @ 0b1100011
	bgeu 	{rs1: register}, {rs2: register}, {value: u12}  => value[11:5] @ rs2 @ rs1 @ 0b111 @ value[4:0] @ 0b1100011
}

; Branch type instructions

#ruledef{
	mv	{rd: register}, {rs1: register}  => 0b000000000000 @ rs1     @ 0b000 @ rd      @ 0b0010011
	mvi 	{rd: register}, {value: i12}  	 => value 	   @ 0b00000 @ 0b000 @ rd      @ 0b0010011
	nop 					 => 0b000000000000 @ 0b00000 @ 0b000 @ 0b00000 @ 0b0010011
	j	{value: i20}  			 => value 	   @ 0b00000 		       @ 0b1101111
	not 	{rd: register}, {rs1: register}  => 0b100000000000 @ rs1     @ 0b100 @ rd      @ 0b0010011
	inv 	{rd: register}, {rs1: register}  => 0b100000000000 @ rs1     @ 0b100 @ rd      @ 0b0010011
	seqz 	{rd: register}, {rs1: register}  => 0b000000000000 @ rs1     @ 0b011 @ rd      @ 0b0010011
	snez 	{rd: register}, {rs2: register}	 => 0b000000000000 @ rs2     @ 0b001 @ rd      @ 0b0010011
	beqz 	{rs1: register}, {value: i12}  	 => value @ 0b00000 @ 0b000 @ rs1 @ 0b1100011
	bnez 	{rs1: register}, {value: i12}    => value @ 0b00000 @ 0b001 @ rs1 @ 0b1100011
	jr 	{rs1: register}    		 => 0b000000000000 @ rs1 @ 0b000 @ 0b00000 @ 0b1100111
	
}

; Pseudo instructions
