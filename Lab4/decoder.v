`define ALU_ADDU   3'h0
`define ALU_ADD    3'h2
`define ALU_SUB    3'h3
`define ALU_AND    3'h4
`define ALU_OR     3'h5
`define ALU_NOR    3'h6
`define ALU_XOR    3'h7

// mips_decode: a decoder for MIPS arithmetic instructions
//
// rd_src      (output) - should the destination register be rd (0) or rt (1)
// writeenable (output) - should a new value be captured by the register file
// alu_src2    (output) - should the 2nd ALU source be a register (0), zero extended immediate or sign extended immediate
// alu_op      (output) - control signal to be sent to the ALU
// except      (output) - set to 1 when the opcode/funct combination is unrecognized
// opcode      (input)  - the opcode field from the instruction
// funct       (input)  - the function field from the instruction
//

module mips_decode(rd_src, writeenable, alu_src2, alu_op, except, opcode, funct);
    output       rd_src, writeenable, except;
    output [1:0] alu_src2;
    output [2:0] alu_op;
    input  [5:0] opcode, funct;

    wire _add = (opcode == `OP_OTHER0) & (funct == `OP0_ADD);
    wire _sub = (opcode == `OP_OTHER0) & (funct == `OP0_SUB);
    wire _and = (opcode == `OP_OTHER0) & (funct == `OP0_AND);
    wire _or = (opcode == `OP_OTHER0) & (funct == `OP0_OR);
    wire _nor = (opcode == `OP_OTHER0) & (funct == `OP0_NOR);
    wire _xor = (opcode == `OP_OTHER0) & (funct == `OP0_XOR);
    wire _addi = (opcode == `OP_ADDI);
    wire _andi = (opcode == `OP_ANDI);
    wire _ori = (opcode == `OP_ORI);
    wire _xori = (opcode == `OP_XORI);

    assign rd_src = _addi | _andi | _ori | _xori;
    assign writeenable = _add | _sub | _and | _or | _nor | _xor | _addi | _andi | _ori | _xori;
    assign alu_src2[0] = _addi;
    assign alu_src2[1] = _andi | _ori | _xori;
    assign alu_op = _add ? `ALU_ADD:
            _sub ? `ALU_SUB:
            _and ? `ALU_AND:
            _or ? `ALU_OR:
            _nor ? `ALU_NOR:
            _xor ? `ALU_XOR:
            _addi ? `ALU_ADD:
            _andi ? `ALU_AND:
            _ori ? `ALU_OR:
            _xori ? `ALU_XOR:
            `ALU_ADDU;
    assign except = ~_add & ~_sub & ~_and & ~_or & ~_nor & ~_xor & ~_addi & ~_andi & ~_ori & ~_xori;
endmodule // mips_decode
