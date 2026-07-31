`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 08:33:54 PM
// Design Name: 
// Module Name: execute
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


module execute(

    // From ID/EX pipeline register
    input wire [31:0] pc,
    input wire [31:0] read_data1,
    input wire [31:0] read_data2,
    input wire [31:0] immediate,

    input wire [2:0] funct3,
    input wire [6:0] funct7,
    input wire [1:0] ALUOp,
    input wire ALUSrc,

    // Forwarding Inputs
    input wire [1:0] ForwardA,
    input wire [1:0] ForwardB,

    input wire [31:0] EX_MEM_Data,
    input wire [31:0] MEM_WB_Data,

    // Outputs
    output wire [31:0] ALUResult,
    output wire [31:0] WriteData,
    output wire Zero,
    output wire [31:0] BranchTarget

);
wire [31:0] SrcA;
wire [31:0] SrcB;
wire [31:0] ALUB;
wire [3:0] ALUControlSignal;
forwarding_mux MUX_A(

    .ReadData(read_data1),
    .EX_MEM_Data(EX_MEM_Data),
    .MEM_WB_Data(MEM_WB_Data),
    .ForwardSel(ForwardA),
    .MuxOut(SrcA)

);
forwarding_mux MUX_B(

    .ReadData(read_data2),
    .EX_MEM_Data(EX_MEM_Data),
    .MEM_WB_Data(MEM_WB_Data),
    .ForwardSel(ForwardB),
    .MuxOut(SrcB)

);
//==================================================
// ALUSrc MUX
//==================================================

assign ALUB = (ALUSrc) ? immediate : SrcB;

//==================================================
// ALU Control
//==================================================

ALUControl alu_control(

    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .ALUControl(ALUControlSignal)

);

//==================================================
// ALU
//==================================================

ALU alu(

    .A(SrcA),
    .B(ALUB),
    .ALUControl(ALUControlSignal),
    .Result(ALUResult),
    .Zero(Zero)

);

//==================================================
// Branch Target Address
//==================================================

assign BranchTarget = pc + immediate;

//==================================================
// Store Data
//==================================================

assign WriteData = SrcB;

endmodule
