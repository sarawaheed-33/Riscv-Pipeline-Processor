`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 08:47:49 PM
// Design Name: 
// Module Name: write_back
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
module write_back(

    input wire [1:0] ResultSrc,

    input wire [31:0] ReadData,
    input wire [31:0] ALUResult,
    input wire [31:0] PCPlus4,

    output reg [31:0] WriteBackData

);

always @(*) begin
    case (ResultSrc)

        2'b00: WriteBackData = ALUResult; // R-type, I-type

        2'b01: WriteBackData = ReadData;  // LW

        2'b10: WriteBackData = PCPlus4;   // JAL

        default: WriteBackData = 32'b0;

    endcase
end

endmodule