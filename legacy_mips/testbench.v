
`timescale 1ns / 1ps

module testbench;
    reg clk = 0;
    reg reset = 1;

    always #5 clk = ~clk;

    mips_top DUT (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, testbench);

        #10 reset = 0;
        #100 $finish;
    end
endmodule
