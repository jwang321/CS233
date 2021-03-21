`define ALU_ADDU   3'h0
`define ALU_ADD    3'h2
`define ALU_SUB    3'h3
`define ALU_AND    3'h4
`define ALU_OR     3'h5
`define ALU_NOR    3'h6
`define ALU_XOR    3'h7

// full_machine: execute a series of MIPS instructions from an instruction cache
//
// except (output) - set to 1 when an unrecognized instruction is to be executed.
// clock   (input) - the clock signal
// reset   (input) - set to 1 to set all registers to zero, set to 0 for normal execution.

module full_machine(except, clock, reset);
    output      except;
    input       clock, reset;

    wire [31:0] inst;  
    wire [31:0] PC, nextPC;  
    wire [31:0] A, rtData, rdData, out, B;
    wire [4:0]  rdNum;
    wire [2:0]  alu_op;
    wire [1:0]  alu_src2;
    wire        rd_src, writeenable, except;

    wire [31:0] PC_alu_wire, branch_wire, mem_read_lui_wire, slt_mem_read_wire, byte_load_mem_read_wire, data_out, lui_addm_wire, addm_alu_mux_wire;
    wire [7:0]  dm_mux_byte_load_wire;
    wire [1:0]  control_type;
    wire        mem_read, word_we, byte_we, byte_load, slt, lui, addm;
    wire        overflow, zero, negative;
    // DO NOT comment out or rename this module
    // or the test bench will break
    register #(32) PC_reg(PC, nextPC, clock, 1'b1, reset);

    // DO NOT comment out or rename this module
    // or the test bench will break
    instruction_memory im(inst, PC[31:2]);

    // DO NOT comment out or rename this module
    // or the test bench will break
    regfile rf (A, rtData,
                inst[25:21], inst[20:16], rdNum, rdData, 
                writeenable, clock, reset);

    /* add other modules */
    mips_decode MIPS_id(alu_op, writeenable, rd_src, alu_src2, except, control_type,
                   mem_read, word_we, byte_we, byte_load, slt, lui, addm,
                   inst[31:26], inst[5:0], zero);
    mux4v alu_src2_mux(B, rtData, {{16{inst[15]}},inst[15:0]}, {{16{1'b0}},inst[15:0]}, 32'b0, alu_src2[1:0]);
    alu32 rf_alu(out, overflow, zero, negative, A, B, alu_op[2:0]);
    mux2v #(5) rd_mux(rdNum, inst[15:11], inst[20:16], rd_src);
    alu32 PC_alu(PC_alu_wire, , , , PC, 32'd4, `ALU_ADD);
    alu32 branch_alu(branch_wire, , , , PC_alu_wire, {{14{inst[15]}},inst[15:0],2'b0}, `ALU_ADD);
    mux4v control_mux(nextPC, PC_alu_wire, branch_wire, {PC_alu_wire[31:28],inst[25:0],2'b0},A,control_type);
    mux2v lui_mux(lui_addm_wire, mem_read_lui_wire, {inst[15:0],{16{1'b0}}}, lui);
    mux2v mem_read_mux(mem_read_lui_wire, slt_mem_read_wire, byte_load_mem_read_wire, mem_read);
    mux2v slt_mux(slt_mem_read_wire, out, {{31{1'b0}},negative}, slt);
    data_mem dm(data_out, out, rtData, word_we, byte_we, clock, reset);
    mux4v #(8) dm_mux(dm_mux_byte_load_wire, data_out[7:0], data_out[15:8], data_out[23:16], data_out[31:24], out[1:0]);
    mux2v byte_load_mux(byte_load_mem_read_wire, data_out, {{24{1'b0}},dm_mux_byte_load_wire}, byte_load);
    alu32 addm_alu(addm_alu_mux_wire, , , , out, data_out, `ALU_ADD);
    mux2v addm_mux(rdData, lui_addm_wire, addm_alu_mux_wire, addm);
endmodule // full_machine
