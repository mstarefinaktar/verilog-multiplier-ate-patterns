module mips_top (
    input clk,
    input reset
);
    wire [31:0] pc, instruction;
    wire [4:0] rs, rt, rd;

    if_stage IF (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction)
    );

    id_stage ID (
        .instruction(instruction),
        .rs(rs),
        .rt(rt),
        .rd(rd)
    );
endmodule
