`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 07:37:28 PM
// Design Name: 
// Module Name: instruction_fetch
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


module instruction_fetch(

    input wire clk,
    input wire rst,

    // From EX stage
    input wire pc_src,
    input wire [31:0] branch_target,
    input wire PCWrite,

    output wire [31:0] instruction,
    output wire [31:0] pc,
    output wire [31:0] pc_plus4

);

wire [31:0] next_pc;

//==========================
// Next PC MUX
//==========================

assign next_pc = (pc_src) ? branch_target : pc_plus4;

//==========================
// PC + 4
//==========================

assign pc_plus4 = pc + 32'd4;

//==========================
// Program Counter
//==========================

ProgramCounter PC(

    .clk(clk),
    .rst(rst),
    .next_pc(next_pc),
    .PCWrite(PCWrite),
    .pc(pc)

);

//==========================
// Instruction Memory
//==========================

Memory #(

    .DATA_FILE("Program.hex")

)

InstructionMemory(

    .Clk(clk),

    .WrEn(4'b0000),

    .Address(pc),

    .WriteData(32'b0),

    .ReadData(instruction)

);

endmodule

