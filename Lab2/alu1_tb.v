module alu1_test;
    // exhaustively test your 1-bit ALU implementation by adapting mux4_tb.v
    reg A = 0;
    always #1 A = !A;
    reg B = 0;
    always #2 B = !B;
    reg carryin = 0;
    always #4 carryin = !carryin;
     
    reg [2:0] control = 0;

    initial begin
        $dumpfile("alu1.vcd");
        $dumpvars(0, alu1_test);

        // control is initially 0
        # 16 control = 2; // wait 16 time units (why 16?) and then set it to 1
        # 16 control = 3; // wait 16 time units and then set it to 2
        # 16 control = 4; // wait 16 time units and then set it to 3
        # 16 control = 5; // wait 16 time units and then set it to 3
        # 16 control = 6; // wait 16 time units and then set it to 3
        # 16 control = 7; // wait 16 time units and then set it to 3
        # 16 $finish; // wait 16 time units and then end the simulation
    end

    wire out, carryout;
    alu1 alu1_1(out, carryout, A, B, carryin, control);
endmodule
