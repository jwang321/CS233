//implement a test bench for your 32-bit ALU
module alu32_test;
    reg [31:0] A = 0, B = 0;
    reg [2:0] control = 0;

    initial begin
        $dumpfile("alu32.vcd");
        $dumpvars(0, alu32_test);

             A = 8; B = 4; control = `ALU_ADD; // try adding 8 and 4
        # 10 A = 2; B = 5; control = `ALU_SUB; // try subtracting 5 from 2
        // add more test cases here!
        # 10 A = 2147483648; B = 2147483648; control = `ALU_ADD;
        # 10 A = 2147483648; B = 2147483699; control = `ALU_ADD;
        # 10 A = 10; B = 9; control = `ALU_SUB;
        # 10 A = 7; B = 7; control = `ALU_SUB;
        # 10 A = 0; B = 0; control = `ALU_AND;
        # 10 A = 0; B = 1; control = `ALU_AND;
        # 10 A = 1; B = 0; control = `ALU_AND;
        # 10 A = 1; B = 1; control = `ALU_AND;
        # 10 A = 0; B = 16; control = `ALU_AND;
        # 10 A = 16; B = 0; control = `ALU_AND;
        # 10 A = 16; B = 16; control = `ALU_AND;
        # 10 A = 0; B = 2147483648; control = `ALU_AND;
        # 10 A = 2147483648; B = 0; control = `ALU_AND;
        # 10 A = 2147483648; B = 2147483648; control = `ALU_AND;
        # 10 A = 0; B = 1073741824; control = `ALU_AND;
        # 10 A = 1073741824; B = 0; control = `ALU_AND;
        # 10 A = 1073741824; B = 1073741824; control = `ALU_AND;
        # 10 A = 0; B = 0; control = `ALU_OR;
        # 10 A = 0; B = 1; control = `ALU_OR;
        # 10 A = 1; B = 0; control = `ALU_OR;
        # 10 A = 1; B = 1; control = `ALU_OR;
        # 10 A = 0; B = 255; control = `ALU_OR;
        # 10 A = 255; B = 0; control = `ALU_OR;
        # 10 A = 255; B = 255; control = `ALU_OR;
        # 10 A = 0; B = 3221225472; control = `ALU_OR;
        # 10 A = 3221225472; B = 0; control = `ALU_OR;
        # 10 A = 3221225472; B = 3221225472; control = `ALU_OR;
        # 10 A = 0; B = 0; control = `ALU_NOR;
        # 10 A = 0; B = 1; control = `ALU_NOR;
        # 10 A = 1; B = 0; control = `ALU_NOR;
        # 10 A = 1; B = 1; control = `ALU_NOR;
        # 10 A = 0; B = 255; control = `ALU_NOR;
        # 10 A = 255; B = 0; control = `ALU_NOR;
        # 10 A = 255; B = 255; control = `ALU_NOR;
        # 10 A = 0; B = 3221225472; control = `ALU_NOR;
        # 10 A = 3221225472; B = 0; control = `ALU_NOR;
        # 10 A = 3221225472; B = 3221225472; control = `ALU_NOR;
        # 10 A = 0; B = 0; control = `ALU_XOR;
        # 10 A = 0; B = 1; control = `ALU_XOR;
        # 10 A = 1; B = 0; control = `ALU_XOR;
        # 10 A = 1; B = 1; control = `ALU_XOR;
        # 10 A = 0; B = 255; control = `ALU_XOR;
        # 10 A = 255; B = 0; control = `ALU_XOR;
        # 10 A = 255; B = 255; control = `ALU_XOR;
        # 10 A = 0; B = 3221225472; control = `ALU_XOR;
        # 10 A = 3221225472; B = 0; control = `ALU_XOR;
        # 10 A = 3221225472; B = 3221225472; control = `ALU_XOR;
        # 10 $finish;
    end

    wire [31:0] out;
    wire overflow, zero, negative;
    alu32 a(out, overflow, zero, negative, A, B, control);  
endmodule // alu32_test