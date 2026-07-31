`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 11:05:07
// Design Name: 
// Module Name: programCounter
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



module ProgramCounter(
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] next_pc,
    input wire PCWrite,
    output reg  [31:0] pc
);

always @(posedge clk or posedge rst)
begin
    if(rst)
        pc <= 32'd0;
    else if (PCWrite)
        pc <= next_pc;
end

endmodule

