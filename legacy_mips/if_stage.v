module if_stage (
    input clk,
    input reset,
    output reg [31:0] pc,
    output [31:0] instruction
);

    reg [31:0] imem [0:31];

    initial begin
        imem[0] = 32'h00000000;
        imem[1] = 32'h20080005;  // addi $t0, $zero, 5
        imem[2] = 32'h20090006;  // addi $t1, $zero, 6
    end

    assign instruction = imem[pc[6:2]];

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= pc + 4;
    end
endmodule
