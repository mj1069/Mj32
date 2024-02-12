# Mj32
32 bit RISC V Microprocessor
32 BIT MICROPROCESSOR IMPLEMENTATION USING RISC-V ISA



Table of content


Table of content	1
Registers	2
Instructions format	3
R-type	4
‘funct3’ and ‘funct7’ in R type instructions	4
I-type	5
‘funct3’ in I type instructions	5
S-type	6
‘funct3’ in S type instructions	6
B-type	7
‘funct3’ in B type instructions	7
3 Address format instructions	8
Encoding difference between B and S type instructions	8



Introduction


Registers

RISC-V is a family of open and extensible instruction set architectures (ISA) that are based on the reduced instruction set computer (RISC) design principles. RISC-V has a base integer ISA, which can be extended with optional standard extensions for different purposes1
The base integer ISA has four variants: RV32I, RV64I, RV128I, and RV32E, which differ in the size of the registers and the address space. RV32I is the most common variant, which has 32-bit registers and a 32-bit address space. RV32E is a reduced variant, which has only 16 registers for embedded applications2
Registers are temporary storage locations for data and instructions that are accessed by the processor. RISC-V has 32 registers, each of which can hold a 32-bit value. The registers are numbered from 0 to 31 and have the following names and functions:
x0: The zero register, which always holds the value 0 and cannot be written.
x1: The return address register, which holds the address of the instruction to return to after a function call.
x2: The stack pointer register, which holds the address of the top of the stack.
x3: The global pointer register, which holds the address of the global data area.
x4: The thread pointer register, which holds the address of the thread-local storage area.
x5-x7: The temporary registers, which are used to hold intermediate values and do not need to be preserved across function calls.
x8: The frame pointer register, which holds the address of the current stack frame.
x9: The alternate link register, which can be used to hold another return address for nested function calls.
x10-x11: The argument registers, which are used to pass the first two arguments to a function and return values from a function.
x12-x17: The argument/temporary registers, which are used to pass the remaining arguments to a function and do not need to be preserved across function calls.
x18-x27: The saved registers, which are used to hold values that need to be preserved across function calls.
x28-x31: The temporary registers, which are used to hold intermediate values and do not need to be preserved across function calls.
The register names can also be prefixed with a letter to indicate the type of the value they hold. For example, x10 can also be called a0, which means it holds an argument or a return value. The letters are:
a: argument or return value
s: saved value
t: temporary value
ra: return address
sp: stack pointer
gp: global pointer
tp: thread pointer
fp: frame pointer
The following table summarizes the register names and functions:
Number
ABI Name
Description
x0
zero
The zero register
x1
ra
The return address
x2
sp
The stack pointer
x3
gp
The global pointer
x4
tp
The thread pointer
x5
t0
The temporary register 0
x6
t1
The temporary register 1
x7
t2
The temporary register 2
x8
s0/fp
The saved register 0 or the frame pointer
x9
s1
The saved register 1
x10
a0
The argument/return value register 0
x11
a1
The argument/return value register 1
x12
a2
The argument register 2
x13
a3
The argument register 3
x14
a4
The argument register 4
x15
a5
The argument register 5
x16
a6
The argument register 6
x17
a7
The argument register 7
x18
s2
The saved register 2
x19
s3
The saved register 3
x20
s4
The saved register 4
x21
s5
The saved register 5
x22
s6
The saved register 6
x23
s7
The saved register 7
x24
s8
The saved register 8
x25
s9
The saved register 9
x26
s10
The saved register 10
x27
s11
The saved register 11
x28
t3
The temporary register 3
x29
t4
The temporary register 4
x30
t5
The temporary register 5
x31
t6
The temporary register 6

1: RISC-V Instruction Sets - Devopedia 2: RISC-V Instruction Set Manual, Volume I: RISC-V User-Level ISA

Instructions format

RISC-V is a family of open and extensible instruction set architectures (ISA) that are based on the reduced instruction set computer (RISC) design principles. RISC-V has a base integer ISA, which can be extended with optional standard extensions for different purposes1
The base integer ISA has four variants: RV32I, RV64I, RV128I, and RV32E, which differ in the size of the registers and the address space. RV32I is the most common variant, which has 32-bit registers and a 32-bit address space. RV32E is a reduced variant, which has only 16 registers for embedded applications2
The base integer ISA defines six types of instructions: R, I, S, B, U, and J, which have different formats and operands. The instruction types are:
R-type

These instructions have three register operands: two source registers and one destination register. They perform arithmetic or logical operations on the source operands and store the result in the destination register. For example, add x1, x2, x3 adds the values in registers x2 and x3 and stores the result in register x12
‘funct3’ and ‘funct7’ in R type instructions

The funct3 and funct7 fields are used to encode the specific operation for R-type instructions. They are derived from the opcode and the mnemonic of the instruction. For example, the opcode for all R-type instructions in the base integer instruction set is 0110011. The funct3 and funct7 fields are then determined by the following table:
Mnemonic
Meaning
funct7
funct3
ADD
Add
0000000
000
SUB
Subtract
0100000
000
SLL
Shift left logical
0000000
001
SRL
Shift right logical
0000000
101
SRA
Shift right arithmetic
0100000
101
SLT
Set less than
0000000
010
SLTU
Set less than unsigned
0000000
011
XOR
Exclusive OR
0000000
100
OR
Inclusive OR
0000000
110
AND
And
0000000
111

For example, to encode the instruction ADD x1, x2, x3, which adds the values in registers x2 and x3 and stores the result in register x1, we use the following format:
funct7
rs2
rs1
funct3
rd
opcode
0000000
00010
00011
000
00001
0110011

The binary encoding of this instruction is 00000000001100010000000110110011.

I-type
These instructions have two register operands and a 12-bit immediate value. They perform arithmetic or logical operations on one source register and the immediate value and store the result in the destination register. They can also be used for load instructions, which load a value from a memory address computed by adding the immediate value to the base register. For example, addi x1, x2, 10 adds 10 to the value in register x2 and stores the result in register x1. lw x1, 100(x2) loads a word from the memory address obtained by adding 100 to the value in register x2 and stores it in register x12
‘funct3’ in I type instructions

Funct3 is a 3-bit field in the I-type instruction format that specifies the type of operation to be performed. Different I-type instructions use different values of funct3 to distinguish them. For example, the following table shows some of the possible values of funct3 for I-type instructions:
Instruction
Opcode
Funct3
Meaning
ADDI
0010011
000
Add immediate
SLTI
0010011
010
Set less than immediate
ANDI
0010011
111
And immediate
LW
0000011
010
Load word
JALR
1100111
000
Jump and link register

To generate the funct3 field for an I-type instruction, one can look up the corresponding value in the instruction set manual or use a mnemonic rule based on the opcode and the operation. For example, for the arithmetic and logical instructions with opcode 0010011, the funct3 field is the same as the last three bits of the operation name. For example, ADDI has funct3 = 000, SLTI has funct3 = 010, and ANDI has funct3 = 111. For the load and store instructions with opcode 0000011 and 0100011, the funct3 field indicates the size and sign-extension of the data. For example, LW has funct3 = 010, which means load a 32-bit word and sign-extend it to XLEN bits. For the control transfer instructions with opcode 1100111 and 1100011, the funct3 field indicates the type of branch or jump. For example, JALR has funct3 = 000, which means jump and link to the address in register plus immediate.
S-type

These instructions have two register operands and a 12-bit immediate value. They are used for store instructions, which store a value from a source register to a memory address computed by adding the immediate value to the base register. For example, sw x1, 100(x2) stores a word from register x1 to the memory address obtained by adding 100 to the value in register x22
‘funct3’ in S type instructions

Funct3 is a 3-bit field in the S-type instruction format that specifies the size and sign-extension of the data to be stored. Different S-type instructions use different values of funct3 to distinguish them. For example, the following table shows some of the possible values of funct3 for S-type instructions:
Instruction
Opcode
Funct3
Meaning
SB
0100011
000
Store byte
SH
0100011
001
Store half-word
SW
0100011
010
Store word

To generate the funct3 field for an S-type instruction, one can look up the corresponding value in the instruction set manual or use a mnemonic rule based on the opcode and the size of the data. For example, for the store instructions with opcode 0100011, the funct3 field is the same as the last three bits of the instruction name. For example, SB has funct3 = 000, SH has funct3 = 001, and SW has funct3 = 010.
B-type 

These instructions have two register operands and a 12-bit immediate value. They are used for conditional branch instructions, which compare the values in the source registers and jump to a target address computed by adding the immediate value to the current program counter if the condition is true. For example, beq x1, x2, 8 compares the values in registers x1 and x2 and jumps 8 bytes ahead of the current instruction if they are equal2
‘funct3’ in B type instructions

Funct3 is a 3-bit field in the B-type instruction format that specifies the type of conditional branch to be performed. Different B-type instructions use different values of funct3 to distinguish them. For example, the following table shows some of the possible values of funct3 for B-type instructions:
Instruction
Opcode
Funct3
Meaning
BEQ
1100011
000
Branch if equal
BNE
1100011
001
Branch if not equal
BLT
1100011
100
Branch if less than
BGE
1100011
101
Branch if greater than or equal

To generate the funct3 field for a B-type instruction, one can look up the corresponding value in the instruction set manual or use a mnemonic rule based on the opcode and the condition. For example, for the branch instructions with opcode 1100011, the funct3 field is the same as the last three bits of the instruction name. For example, BEQ has funct3 = 000, BNE has funct3 = 001, and BLT has funct3 = 1001
1: RISC-V Instruction Set Manual, Volume I: RISC-V User-Level ISA
U-type: These instructions have one register operand and a 20-bit immediate value. They are used for loading upper immediate values to the destination register. For example, lui x1, 1000 loads the value 1000 << 12 to register x12

J-type: These instructions have one register operand and a 20-bit immediate value. They are used for unconditional jump instructions, which jump to a target address computed by adding the immediate value to the current program counter and store the address of the next instruction in the destination register. For example, jal x1, 16 jumps 16 bytes ahead of the current instruction and stores the address of the next instruction in register x12
1: RISC-V Instruction Sets - Devopedia 2: RISC-V Instruction Formats - University of California, Berkeley
Opcode

The opcode is a 7-bit field in the instruction format that specifies the type of instruction to be executed. Different types of instructions have different opcodes to distinguish them. For example, the following table shows some of the possible opcodes for R, I, S, B, U, and J type instructions:
Type
Opcode
Meaning
R
0110011
Register-Register Operations
I
0010011
Register-Immediate Operations
S
0100011
Store Operations
B
1100011
Branch Operations
U
0110111
Upper Immediate Operations
J
1101111
Jump Operations

To generate the opcode for an instruction, one can look up the corresponding value in the instruction set manual or use a mnemonic rule based on the type and the operation. For example, for the R-type instructions, the opcode is always 0110011, regardless of the specific operation. For the I-type instructions, the opcode is 0010011 for arithmetic and logical operations, 0000011 for load operations, and 1100111 for control transfer operations. For the S-type instructions, the opcode is always 0100011. For the B-type instructions, the opcode is always 1100011. For the U-type instructions, the opcode is 0110111 for LUI and 0010111 for AUIPC. For the J-type instructions, the opcode is always 11011111
1: RISC-V Instruction Set Manual, Volume I: RISC-V User-Level ISA

3 Address format instructions

RISC-V uses 3 address format instructions. The instructions have one opcode and three address fields. One address field is used for destination and two address fields for source (for example, add x1, x2, x3 adds the values in registers x2 and x3 and stores the result in x1).

Encoding difference between B and S type instructions

The text is about the instruction formats of RISC-V, which is a family of open and extensible instruction set architectures (ISA) that are based on the reduced instruction set computer (RISC) design principles1
An instruction format is the way of encoding and representing the operations that a computer processor can perform. Different instruction formats have different fields and numbers of operands or addresses. RISC-V defines six types of instruction formats: R, I, S, B, U, and J2
The S and B formats are used for store and branch instructions, respectively. They both have a 12-bit immediate field, which is a constant value that is part of the instruction. However, the immediate field is encoded differently in the two formats, as shown in the following table:
Format
Opcode
rs1
rs2
imm[11:5]
funct3
imm[4:0]
S
7 bits
5 bits
5 bits
7 bits
3 bits
5 bits
B
7 bits
5 bits
5 bits
imm[4:1]
3 bits
imm[11]








imm[10:5]


imm[12]

The only difference between the S and B formats is that the 12-bit immediate field is used to encode branch offsets in multiples of 2 in the B format. This means that the branch target address is computed by adding the immediate value, multiplied by 2, to the current program counter. This allows for a larger range of branch targets, since the immediate value can represent up to 4 KiB of offset3
Instead of shifting all bits in the instruction-encoded immediate left by one in hardware as is conventionally done, the middle bits (imm[10:1]) and sign bit stay in fixed positions, while the lowest bit in S format (inst[7]) encodes a high-order bit in B format. This way, bits 10:1 of the immediate field line up exactly with the S format, and the sign bit is in the same position as the other formats. This simplifies the hardware implementation and reduces the number of wires and logic gates needed to decode the immediate field.
1: RISC-V Instruction Sets - Devopedia 2: RISC-V Instruction Formats - University of California, Berkeley 3: RISC-V Instruction Set Manual, Volume I: RISC-V User-Level ISA : Why are RISC-V S-B and U-J instruction types encoded in this way?
Instruction encoding

The instructions you listed are from the RISC-V instruction set architecture (ISA), which is a family of open and extensible ISAs that are based on the reduced instruction set computer (RISC) design principles. RISC-V has a base integer ISA, which can be extended with optional standard extensions for different purposes.
The base integer ISA has four variants: RV32I, RV64I, RV128I, and RV32E, which differ in the size of the registers and the address space. RV32I is the most common variant, which has 32-bit registers and a 32-bit address space. RV32E is a reduced variant, which has only 16 registers for embedded applications.
The base integer ISA defines six types of instructions: R, I, S, B, U, and J, which have different formats and operands. The instruction types are explained in detail in the previous messages.
The opcode is a 7-bit field in the instruction format that specifies the type of instruction to be executed. Different types of instructions have different opcodes to distinguish them. The binary representation of an instruction is the way of encoding the instruction fields and values in binary digits (bits). Each instruction is 32 bits long, and the order and position of the bits depend on the instruction format and type. The binary representation of an instruction can be obtained by concatenating the binary values of the opcode, funct3, funct7, rd, rs1, rs2, and immediate fields, according to the instruction format. The binary values of the registers and the immediate values can be obtained by converting the decimal or hexadecimal values to binary and padding with zeros to the required length. For example, the register x1 has the binary value 00001, and the immediate value 10 has the binary value 0000000000001010.
To generate the opcode and binary representation of all the instructions you listed, I will use the following table, which shows the instruction name, type, opcode, funct3, funct7, and an example of the binary representation. The example assumes that the registers and the immediate values are given in decimal, and the instruction is in RV32I variant. The binary representation may vary depending on the operands and the variant.
S No
Instruction
Type
Opcode
Funct3
Funct7
Example
1
LUI
U
0110111
N/A
N/A
LUI x1, 1000 -> 0000000011110000000000001101111
2
AUIPC
U
0010111
N/A
N/A
AUIPC x1, 1000 -> 0000000011110000000000010010111
3
JAL
J
1101111
N/A
N/A
JAL x1, 16 -> 00000000000100000000000011101111
4
JALR
I
1100111
000
N/A
JALR x1, x2, 10 -> 0000000000100001000000011001111
5
BEQ
B
1100011
000
N/A
BEQ x1, x2, 8 -> 0000000000100001000000001100011
6
BNE
B
1100011
001
N/A
BNE x1, x2, 8 -> 0000000000100001000100001100011
7
BLT
B
1100011
100
N/A
BLT x1, x2, 8 -> 0000000000100001010000001100011
8
BGE
B
1100011
101
N/A
BGE x1, x2, 8 -> 0000000000100001010100001100011
9
BLTU
B
1100011
110
N/A
BLTU x1, x2, 8 -> 0000000000100001011000001100011
10
BGEU
B
1100011
111
N/A
BGEU x1, x2, 8 -> 0000000000100001011100001100011
11
LB
I
0000011
000
N/A
LB x1, 100(x2) -> 000000011001000100000000000011
12
LH
I
0000011
001
N/A
LH x1, 100(x2) -> 000000011001000100010000000011
13
LW
I
0000011
010
N/A
LW x1, 100(x2) -> 000000011001000100100000000011
14
LBU
I
0000011
100
N/A
LBU x1, 100(x2) -> 000000011001000110000000000011
15
LHU
I
0000011
101
N/A
LHU x1, 100(x2) -> 000000011001000110010000000011
16
SB
S
0100011
000
N/A
SB x1, 100(x2) -> 0000000110010001000000000100011
17
SH
S
0100011
001
N/A
SH x1, 100(x2) -> 0000000110010001000100000100011
18
SW
S
0100011
010
N/A
SW x1, 100(x2) -> 0000000110010001001000000100011
19
ADDI
I
0010011
000
N/A
ADDI x1, x2, 10 -> 0000000000100001000000010010011
20
SLTI
I
0010011
010
N/A
SLTI x1, x2, 10 -> 0000000000100001010000010010011
21
SLTIU
I
0010011
011
N/A
SLTIU x1, x2, 10 -> 0000000000100001011000010010011
22
XORI
I
0010011
100
N/A
XORI x1, x2, 10 -> 0000000000100001100000010010011
23
ORI
I
0010011
110
N/A
ORI x1, x2, 10 -> 0000000000100001110000010010011
24
ANDI
I
0010011
111
N/A
ANDI x1, x2, 10 -> 0000000000100001111000010010011
25
SLLI
I
0010011
001
0000000
SLLI x1, x2, 10 -> 0000000000100001000100000010011
26
SRLI
I
0010011
101
0000000
SRLI x1, x2, 10 -> 0000000000100001100100000010011
27
SRAI
I
0010011
101
0100000
SRAI x1, x2, 10 -> 0000000000100001100100000110011
28
ADD
R
0110011
000
0000000
ADD x1, x2, x3 -> 00000000001100010000000110110011
29
SUB
R
0110011
000
0100000
SUB x1, x2, x3 -> 00000000001100010000000111110011
30
SLL
R
0110011
001
0000000
SLL x1, x2, x3 -> 00000000001100010001000110110011
31
SLT
R
0110011
010
0000000
SLT x1, x2, x3 -> 00000000001100010010000110110011
32
SLTU
R
0110011
011
0000000
SLTU x1, x2, x3 -> 00000000001100010011000110110011
33
XOR
R
0110011
100
0000000
XOR x1, x2, x3 -> 00000000001100011000000110110011
34
SRL
R
0110011
101
0000000
SRL x1, x2, x3 -> 00000000001100011001000110110011
35
SRA
R
0110011
101
0100000
SRA x1, x2, x3 -> 00000000001100011001000111110011
36
OR
R
0110011
110
0000000
OR x1, x2, x3 -> 00000000001100011010000110110011
37
AND
R
0110011
111
0000000
AND x1, x2, x3 -> 00000000001100011011000110110011
38
MV
I
0010011
000
N/A
MV x1, x2 -> 0000000000000001000000010010011
39
MVI
I
0010011
000
N/A
MVI x1, 10 -> 0000000000001010000000010010011
40
NOP
I
0010011
000
N/A
NOP -> 0000000000000000000000000010011
41
J
J
1101111
N/A
N/A
J 16 -> 00000000000100000000000011101111
42
NOT
R
0110011
100
0100000
NOT x1, x2 -> 00000000000000011000000111110011
43
INV
R
0110011
100
0100000
INV x1, x2 -> 00000000000000011000000111110011
44
SEQZ
I
0010011
001
N/A
SEQZ x1, x2 -> 0000000000000001000100010010011
45
SNEZ
I
0010011
001
N/A
SNEZ x1, x2 -> 0000000000000001000100010010011
46
BEQZ
B
1100011
000
N/A
BEQZ x1, 8 -> 0000000000000001000000001100011
47
BNEZ
B
1100011
001
N/A
BNEZ x1, 8 -> 0000000000000001000100001100011
48
LI
I
0010011
000
N/A
LI x1, 10 -> 0000000000001010000000010010011
49
LA
U
0110111
N/A
N/A
LA x1, 1000 -> 0000000011110000000000001101111
50
JR
I
1100111
000
N/A
JR x1 -> 0000000000000001000000001100111




