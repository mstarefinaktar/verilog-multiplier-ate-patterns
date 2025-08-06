`timescale 1ns / 1ps

module testbench;

    reg clk = 0;
    reg rst = 1;
    reg valid_in = 0;
    reg [31:0] a = 0, b = 0;
    wire valid_out;
    wire [63:0] result;

    // DUT
    pipelined_multiplier dut (
        .clk(clk),
        .rst(rst),
        .valid_in(valid_in),
        .a(a),
        .b(b),
        .valid_out(valid_out),
        .result(result)
    );

    // Clock generation
    always #5 clk = ~clk;

    // File handle
    integer f;

    // Main simulation and stimulus
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, testbench);

        // Open CSV file
        f = $fopen("mult_vectors.csv", "w");
        $fwrite(f, "Time_ns,A,B,Result,Valid\n");

        // Deassert reset
        #10 rst = 0;

        // Corner Cases
        #10 valid_in = 1; a = 32'd0;          b = 32'd123;
        #10             a = -32'd1;          b = 32'd1;
        #10             a = 32'h7FFFFFFF;    b = 32'd1;
        #10             a = 32'h80000000;    b = -32'd1;

        // Randomized cases
        #10             a = $random;         b = $random;
        #10             a = $random;         b = $random;
        #10             a = $random;         b = $random;

        // Stop input
        #10 valid_in = 0;

        // Let pipeline drain
        #100;

        $fclose(f);
        $finish;
    end

    // Log only valid results
    always @(posedge clk) begin
        if (valid_out) begin
            $fwrite(f, "%0t,%0d,%0d,%0d,%0b\n", $time, a, b, result, valid_out);
        end
    end

endmodule
