//implement your 32-bit ALU
module alu32(out, overflow, zero, negative, A, B, control);
    output [31:0] out, c_out;
    output        overflow, zero, negative;
    input  [31:0] A, B;
    input   [2:0] control;

    buf buf1(negative, out[31]);
    nor nor1(zero, out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7], out[8], out[9], out[10], out[11], out[12], out[13], out[14], out[15], out[16], out[17], out[18], out[19], out[20], out[21], out[22], out[23], out[24], out[25], out[26], out[27], out[28], out[29], out[30], out[31]);
    xor xor1(overflow, c_out[31], c_out[30]);

    alu1 alu1_0(out[0], c_out[0], A[0], B[0], control[0], control);
    alu1 alu1_1(out[1], c_out[1], A[1], B[1], c_out[0], control);
    alu1 alu1_2(out[2], c_out[2], A[2], B[2], c_out[1], control);
    alu1 alu1_3(out[3], c_out[3], A[3], B[3], c_out[2], control);
    alu1 alu1_4(out[4], c_out[4], A[4], B[4], c_out[3], control);
    alu1 alu1_5(out[5], c_out[5], A[5], B[5], c_out[4], control);
    alu1 alu1_6(out[6], c_out[6], A[6], B[6], c_out[5], control);
    alu1 alu1_7(out[7], c_out[7], A[7], B[7], c_out[6], control);
    alu1 alu1_8(out[8], c_out[8], A[8], B[8], c_out[7], control);
    alu1 alu1_9(out[9], c_out[9], A[9], B[9], c_out[8], control);
    alu1 alu1_10(out[10], c_out[10], A[10], B[10], c_out[9], control);
    alu1 alu1_11(out[11], c_out[11], A[11], B[11], c_out[10], control);
    alu1 alu1_12(out[12], c_out[12], A[12], B[12], c_out[11], control);
    alu1 alu1_13(out[13], c_out[13], A[13], B[13], c_out[12], control);
    alu1 alu1_14(out[14], c_out[14], A[14], B[14], c_out[13], control);
    alu1 alu1_15(out[15], c_out[15], A[15], B[15], c_out[14], control);
    alu1 alu1_16(out[16], c_out[16], A[16], B[16], c_out[15], control);
    alu1 alu1_17(out[17], c_out[17], A[17], B[17], c_out[16], control);
    alu1 alu1_18(out[18], c_out[18], A[18], B[18], c_out[17], control);
    alu1 alu1_19(out[19], c_out[19], A[19], B[19], c_out[18], control);
    alu1 alu1_20(out[20], c_out[20], A[20], B[20], c_out[19], control);
    alu1 alu1_21(out[21], c_out[21], A[21], B[21], c_out[20], control);
    alu1 alu1_22(out[22], c_out[22], A[22], B[22], c_out[21], control);
    alu1 alu1_23(out[23], c_out[23], A[23], B[23], c_out[22], control);
    alu1 alu1_24(out[24], c_out[24], A[24], B[24], c_out[23], control);
    alu1 alu1_25(out[25], c_out[25], A[25], B[25], c_out[24], control);
    alu1 alu1_26(out[26], c_out[26], A[26], B[26], c_out[25], control);
    alu1 alu1_27(out[27], c_out[27], A[27], B[27], c_out[26], control);
    alu1 alu1_28(out[28], c_out[28], A[28], B[28], c_out[27], control);
    alu1 alu1_29(out[29], c_out[29], A[29], B[29], c_out[28], control);
    alu1 alu1_30(out[30], c_out[30], A[30], B[30], c_out[29], control);
    alu1 alu1_31(out[31], c_out[31], A[31], B[31], c_out[30], control);
endmodule // alu32