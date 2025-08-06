`timescale 1ns / 1ps

module testbench;
    reg clk = 0;
    reg rst = 1;
    reg valid_in = 0;
    reg [31:0] a = 0, b = 0;
    wire valid_out;
    wire [63:0] result;

    pipelined_multiplier dut (
        .clk(clk),
        .rst(rst),
        .valid_in(valid_in),
        .a(a),
        .b(b),
        .valid_out(valid_out),
        .result(result)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, testbench);
        #10 rst = 0;

        #10 valid_in = 1; a = 32'd5;  b = 32'd6;
        #10 valid_in = 1; a = 32'd10; b = -32'd3;
        #10 valid_in = 1; a = 32'd8;  b = 32'd2;
        #10 valid_in = 0;

        #100;
        $finish;
    end
endmodule
