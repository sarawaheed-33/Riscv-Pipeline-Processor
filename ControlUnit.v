`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 12:24:03
// Design Name: 
// Module Name: ControlUnit
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
module ControlUnit(
    input  wire [6:0] opcode,

    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg ALUSrc,
    output reg Branch,
    output reg Jump,

    output reg [1:0] ResultSrc,
    output reg [1:0] ALUOp
);

always @(*) begin

    // Default values
    RegWrite = 1'b0;
    MemRead  = 1'b0;
    MemWrite = 1'b0;
    ALUSrc   = 1'b0;
    Branch   = 1'b0;
    Jump     = 1'b0;
    ResultSrc= 2'b00;
    ALUOp    = 2'b00;

    case(opcode)

        
        // R-Type
    
        7'b0110011:
        begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b0;
            ResultSrc= 2'b00;
            ALUOp    = 2'b10;
        end

       
        // I-Type Arithmetic
        // ADDI, ANDI, ORI, XORI, SLTI
        
        7'b0010011:
        begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b1;
            ResultSrc= 2'b00;
            ALUOp    = 2'b11;
        end

        
        // Load Word (LW)
       
        7'b0000011:
        begin
            RegWrite = 1'b1;
            MemRead  = 1'b1;
            ALUSrc   = 1'b1;
            ResultSrc= 2'b01;
            ALUOp    = 2'b00;
        end

     
        // Store Word (SW)
        
        7'b0100011:
        begin
            MemWrite = 1'b1;
            ALUSrc   = 1'b1;
            ALUOp    = 2'b00;
        end

        
        // Branch Instructions
        
        7'b1100011:
        begin
            Branch = 1'b1;
            ALUOp  = 2'b01;
        end

        
        // JAL
        
        7'b1101111:
        begin
            Jump      = 1'b1;
            RegWrite  = 1'b1;
            ResultSrc = 2'b10;
        end

        
        // JALR
       
        7'b1100111:
        begin
            Jump      = 1'b1;
            RegWrite  = 1'b1;
            ALUSrc    = 1'b1;
            ResultSrc = 2'b10;
        end

     
        // LUI
        
        7'b0110111:
        begin
            RegWrite  = 1'b1;
            ResultSrc = 2'b11;
        end

        // AUIPC
        7'b0010111:
        begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b1;
            ResultSrc= 2'b00;
            ALUOp    = 2'b00;
        end

        default:
        begin
            RegWrite = 1'b0;
            MemRead  = 1'b0;
            MemWrite = 1'b0;
            ALUSrc   = 1'b0;
            Branch   = 1'b0;
            Jump     = 1'b0;
            ResultSrc= 2'b00;
            ALUOp    = 2'b00;
        end

    endcase

end

endmodule