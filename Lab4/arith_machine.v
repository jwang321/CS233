`define ALU_ADDU   3'h0
`define ALU_ADD    3'h2
`define ALU_SUB    3'h3
`define ALU_AND    3'h4
`define ALU_OR     3'h5
`define ALU_NOR    3'h6
`define ALU_XOR    3'h7

// arith_machine: execute a series of arithmetic instructions from an instruction cache
//
// except (output) - set to 1 when an unrecognized instruction is to be executed.
// clock  (input)  - the clock signal
// reset  (input)  - set to 1 to set all registers to zero, set to 0 for normal execution.

module arith_machine(except, clock, reset);
    output      except;
    input       clock, reset;

    wire [31:0] inst;  
    wire [31:0] PC, nextPC;  
    wire [31:0] rsData, rtData, rdData, alu_src;
    wire [4:0]  rdNum;
    wire [2:0]  alu_op;
    wire [1:0]  alu_src2;
    wire        rd_src, writeenable, except;
    // DO NOT comment out or rename this module
    // or the test bench will break
    register #(32) PC_reg(PC, nextPC, clock, 1'b1, reset);

    // DO NOT comment out or rename this module
    // or the test bench will break
    instruction_memory im(inst, PC[31:2]);

    // DO NOT comment out or rename this module
    // or the test bench will break
    regfile rf (rsData, rtData,
                inst[25:21], inst[20:16], rdNum, rdData, 
                writeenable, clock, reset);

    /* add other modules */
    mips_decode MIPS_id(rd_src, writeenable, alu_src2[1:0], alu_op[2:0], except, inst[31:26], inst[5:0]);
    mux3v alu_src2_mux(alu_src, rtData, {{16{inst[15]}},inst[15:0]}, {{16{1'b0}},inst[15:0]}, alu_src2[1:0]);
    alu32 rf_alu(rdData, overflow, zero, negative, rsData, alu_src, alu_op[2:0]);
    mux2v #(5) rd_mux(rdNum, inst[15:11], inst[20:16], rd_src);
    alu32 PC_alu(nextPC, , , , PC, 32'd4, `ALU_ADD);
endmodule // arith_machine