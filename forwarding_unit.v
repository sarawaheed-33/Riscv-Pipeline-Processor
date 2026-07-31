`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 08:54:14 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(

    // Source registers from ID/EX stage
    input wire [4:0] rs1_EX,
    input wire [4:0] rs2_EX,

    // Destination register from EX/MEM stage
    input wire [4:0] rd_MEM,
    input wire RegWrite_MEM,

    // Destination register from MEM/WB stage
    input wire [4:0] rd_WB,
    input wire RegWrite_WB,

    // Control signals for forwarding MUXes
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB

);

always @(*)
begin

    // Default: No forwarding
    ForwardA = 2'b00;
    ForwardB = 2'b00;

    //-----------------------------
    // Forward A
    //-----------------------------
    if (RegWrite_MEM &&
        (rd_MEM != 5'b00000) &&
        (rd_MEM == rs1_EX))
    begin
        ForwardA = 2'b10;
    end
    else if (RegWrite_WB &&
             (rd_WB != 5'b00000) &&
             (rd_WB == rs1_EX))
    begin
        ForwardA = 2'b01;
    end

    //-----------------------------
    // Forward B
    //-----------------------------
    if (RegWrite_MEM &&
        (rd_MEM != 5'b00000) &&
        (rd_MEM == rs2_EX))
    begin
        ForwardB = 2'b10;
    end
    else if (RegWrite_WB &&
             (rd_WB != 5'b00000) &&
             (rd_WB == rs2_EX))
    begin
        ForwardB = 2'b01;
    end

end

endmodule
