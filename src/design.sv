module pipelined_multiplier (
    input wire clk,
    input wire rst,
    input wire valid_in,
    input wire [31:0] a,
    input wire [31:0] b,
    output reg valid_out,
    output reg [63:0] result
);

    reg [31:0] a_reg, b_reg;
    reg valid_s1;

    reg [63:0] product_reg;
    reg valid_s2;

    reg [63:0] result_reg;
    reg valid_s3;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            a_reg <= 0;
            b_reg <= 0;
            valid_s1 <= 0;
        end else if (valid_in) begin
            a_reg <= a;
            b_reg <= b;
            valid_s1 <= 1;
        end else begin
            valid_s1 <= 0;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            product_reg <= 0;
            valid_s2 <= 0;
        end else if (valid_s1) begin
            product_reg <= $signed(a_reg) * $signed(b_reg);
            valid_s2 <= 1;
        end else begin
            valid_s2 <= 0;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result_reg <= 0;
            valid_s3 <= 0;
        end else if (valid_s2) begin
            result_reg <= product_reg;
            valid_s3 <= 1;
        end else begin
            valid_s3 <= 0;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result <= 0;
            valid_out <= 0;
        end else begin
            result <= result_reg;
            valid_out <= valid_s3;
        end
    end
endmodule
