`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 08:45:38 PM
// Design Name: 
// Module Name: memory_stage
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


module memory_stage(

    input wire clk,

    input wire MemRead,
    input wire MemWrite,

    input wire [31:0] ALUResult,
    input wire [31:0] WriteData,

    output wire [31:0] ReadData,
    output wire [31:0] ALUResultOut

);

//==============================
// Data Memory
//==============================

Memory #(

    .DATA_FILE("Data.hex")

)

DataMemory(

    .Clk(clk),

    .WrEn(MemWrite ? 4'b1111 : 4'b0000),

    .Address(ALUResult),

    .WriteData(WriteData),

    .ReadData(ReadData)

);

//==============================
// Pass ALU Result
//==============================

assign ALUResultOut = ALUResult;

endmodule
