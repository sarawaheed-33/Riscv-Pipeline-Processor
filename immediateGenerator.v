`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 11:45:07
// Design Name: 
// Module Name: immediateGenerator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module immediateGenerator(
    input  wire [31:0] instruction,
    output reg  [31:0] immediate
);

localparam OP_IMM  = 7'b0010011;  // ADDI, ANDI, ORI, XORI, SLTI
localparam LOAD    = 7'b0000011;  // LW
localparam JALR    = 7'b1100111;  // JALR
localparam STORE   = 7'b0100011;  // SW
localparam BRANCH  = 7'b1100011;  // BEQ, BNE
localparam JAL     = 7'b1101111;  // JAL
localparam LUI     = 7'b0110111;  // LUI
localparam AUIPC   = 7'b0010111;  // AUIPC

wire [6:0] opcode;
assign opcode = instruction[6:0];
always @(*) begin
    case(opcode)

        OP_IMM,
        LOAD,
        JALR:
            immediate = {{20{instruction[31]}}, instruction[31:20]};

        STORE:
            immediate = {{20{instruction[31]}},
                          instruction[31:25],
                          instruction[11:7]};

        BRANCH:
            immediate = {{19{instruction[31]}},
                          instruction[31],
                          instruction[7],
                          instruction[30:25],
                          instruction[11:8],
                          1'b0};

        JAL:
            immediate = {{11{instruction[31]}},
                          instruction[31],
                          instruction[19:12],
                          instruction[20],
                          instruction[30:21],
                          1'b0};

        LUI,
        AUIPC:
            immediate = {instruction[31:12], 12'b0};

        default:
            immediate = 32'd0;
    endcase
end
endmodule