`define ALU_ADDU   3'h0
`define ALU_ADD    3'h2
`define ALU_SUB    3'h3
`define ALU_AND    3'h4
`define ALU_OR     3'h5
`define ALU_NOR    3'h6
`define ALU_XOR    3'h7

// mips_decode: a decoder for MIPS arithmetic instructions
//
// alu_op       (output) - control signal to be sent to the ALU
// writeenable  (output) - should a new value be captured by the register file
// rd_src       (output) - should the destination register be rd (0) or rt (1)
// alu_src2     (output) - should the 2nd ALU source be a register (0) or an immediate (1)
// except       (output) - set to 1 when we don't recognize an opdcode & funct combination
// control_type (output) - 00 = fallthrough, 01 = branch_target, 10 = jump_target, 11 = jump_register 
// mem_read     (output) - the register value written is coming from the memory
// word_we      (output) - we're writing a word's worth of data
// byte_we      (output) - we're only writing a byte's worth of data
// byte_load    (output) - we're doing a byte load
// slt          (output) - the instruction is an slt
// lui          (output) - the instruction is a lui
// addm         (output) - the instruction is an addm
// opcode        (input) - the opcode field from the instruction
// funct         (input) - the function field from the instruction
// zero          (input) - from the ALU
//

module mips_decode(alu_op, writeenable, rd_src, alu_src2, except, control_type,
                   mem_read, word_we, byte_we, byte_load, slt, lui, addm,
                   opcode, funct, zero);
    output [2:0] alu_op;
    output [1:0] alu_src2;
    output       writeenable, rd_src, except;
    output [1:0] control_type;
    output       mem_read, word_we, byte_we, byte_load, slt, lui, addm;
    input  [5:0] opcode, funct;
    input        zero;

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
    wire _bne = (opcode == `OP_BNE);
    wire _beq = (opcode == `OP_BEQ);
    wire _j = (opcode == `OP_J);
    wire _jr = (opcode == `OP_OTHER0) & (funct == `OP0_JR);
    wire _lui = (opcode == `OP_LUI);
    wire _slt = (opcode == `OP_OTHER0) & (funct == `OP0_SLT);
    wire _lw = (opcode == `OP_LW);
    wire _lbu = (opcode == `OP_LBU);
    wire _sw = (opcode == `OP_SW);
    wire _sb = (opcode == `OP_SB);
    wire _addm = (opcode == `OP_OTHER0) & (funct == `OP0_ADDM);

    assign control_type = _bne & ~zero ? 1:
            _beq & zero ? 1:
            _j ? 2:
            _jr ? 3:
            0;
    assign rd_src = _addi | _andi | _ori | _xori | _lui | _lw | _lbu;
    assign writeenable = _add | _sub | _and | _or | _nor | _xor | _addi | _andi | _ori | _xori | _lui | _slt | _lw | _lbu | _addm;
    assign alu_src2[0] = _addi | _lw | _lbu | _sw | _sb | _addm;
    assign alu_src2[1] = _andi | _ori | _xori | _addm;
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
            _bne ? `ALU_SUB:
            _beq ? `ALU_SUB:
            _slt ? `ALU_SUB:
            _lw ? `ALU_ADD:
            _lbu ? `ALU_ADD:
            _sw ? `ALU_ADD:
            _sb ? `ALU_ADD:
            _addm ? `ALU_ADD:
            `ALU_ADDU;
    assign mem_read = _lw | _lbu;
    assign word_we = _sw;
    assign byte_we = _sb;
    assign byte_load = _lbu;
    assign lui = _lui;
    assign slt = _slt;
    assign addm = _addm;
    assign except = ~_add & ~_sub & ~_and & ~_or & ~_nor & ~_xor & ~_addi & ~_andi & ~_ori & ~_xori & ~_bne & ~_beq & ~_j & ~_jr & ~_lui & ~_slt & ~_lw & ~_lbu & ~_sw & ~_sb & ~_addm;
endmodule // mips_decode
