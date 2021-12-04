`define RstEnable  1'b1
`define RstDisable	1'b0
`define RomEnable	1'b1 
`define RomDisable	1'b0

`define RamWrite 1'b1
`define RamUnWrite 1'b0
`define RamEnable 1'b1
`define RamDisable 1'b0

`define Zero	32'h00000000
`define One	32'h00000001
`define WriteEnable	1'b1
`define WriteDisable	1'b0
`define ReadEnable	1'b1
`define ReadDisable	1'b0
`define Valid	1'b0
`define Invalid	1'b1

`define nop	6'b000000

`define pcWriteEnable 1'b1;
`define pcWriteDisable 1'b0;

//20
`define Inst_addi 6'b001000
`define Inst_andi 6'b001100
`define Inst_ori	6'b001101
`define Inst_xori 6'b001110
`define Inst_lw 6'b100011
`define Inst_sw 6'b101011
`define Inst_beq 6'b000100
`define Inst_bne 6'b000101
`define Inst_lui 6'b001111

`define Inst_r   6'b000000
`define Inst_add 6'b100000
`define Inst_sub 6'b100010
`define Inst_and 6'b100100
`define Inst_or  6'b100101
`define Inst_xor 6'b100110
`define Inst_sll 6'b000000
`define Inst_srl 6'b000010
`define Inst_sra 6'b000011
`define Inst_jr  6'b001000

`define Inst_j   6'b000010
`define Inst_jal 6'b000011

//12
`define Inst_slt  6'b101010
`define Inst_bgtz 6'b000111
`define Inst_bltz 6'b000001
`define Inst_jalr 6'b001001
`define Inst_mult 6'b011000
`define Inst_multu 6'b011001
`define Inst_div  6'b011010
`define Inst_divu 6'b011011
`define Inst_mfhi 6'b010000
`define Inst_mflo 6'b010010
`define Inst_mthi 6'b010001
`define Inst_mtlo 6'b010011


//??
`define Add 6'b100000
`define Sub 6'b100010
`define And 6'b100100
`define Or  6'b100101
`define Xor 6'b100110
`define Sll 6'b000000
`define Srl 6'b000010
`define Sra 6'b000011
`define Jr  6'b001000
`define J   6'b000010
`define Jal 6'b000111
`define Lw  6'b100011
`define Sw  6'b101011

`define Slt  6'b101010
`define Mult 6'b011000
`define Multu 6'b011001
`define Div  6'b011010
`define Divu 6'b011011
`define Mfhi 6'b010000
`define Mflo 6'b010010
`define Mthi 6'b010001
`define Mtlo 6'b010011