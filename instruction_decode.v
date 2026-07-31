`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 07:55:33 PM
// Design Name: 
// Module Name: instruction_decode
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

module instruction_decode(

    input wire clk,
    input wire rst,

    // From IF/ID pipeline register
    input wire [31:0] instruction,
    input wire [31:0] pc,

    // Write Back Stage
    input wire reg_write,
    input wire [4:0] wb_rd,
    input wire [31:0] wb_data,

    // Outputs to ID/EX Register
    output wire [31:0] read_data1,
    output wire [31:0] read_data2,
    output wire [31:0] immediate,

    output wire [4:0] rs1,
    output wire [4:0] rs2,
    output wire [4:0] rd,

    output wire [2:0] funct3,
    output wire [6:0] funct7,
    output wire [6:0] opcode,

    // Control Signals
    output wire RegWrite,
    output wire MemRead,
    output wire MemWrite,
    output wire [1:0] ResultSrc,
    output wire ALUSrc,
    output wire Branch,
    output wire Jump,
    output wire [1:0] ALUOp,

    // Hazard Unit
    input wire stall
);

InstructionDecoder decoder(

    .instruction(instruction),

    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7)

);
RegisterFile rf(

    .clk(clk),

    .Reg_write(reg_write),

    .rs1(rs1),
    .rs2(rs2),

    .rd(wb_rd),

    .Write_data(wb_data),

    .Read_data1(read_data1),
    .Read_data2(read_data2)

);
immediateGenerator imm_gen(

    .instruction(instruction),

    .immediate(immediate)

);

ControlUnit cu(

    .opcode(opcode),

    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .ALUSrc(ALUSrc),
    .Branch(Branch),
    .Jump(Jump),
    .ALUOp(ALUOp)

);
endmodule
