module id_stage (
    input [31:0] instruction,
    output [4:0] rs, rt, rd
);
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
endmodule
