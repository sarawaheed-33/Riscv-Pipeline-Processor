`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 12:05:07
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(

    input wire [1:0] ALUOp,

    input wire [2:0] funct3,

    input wire [6:0] funct7,

    output reg [3:0] ALUControl

);

always @(*) begin

    case(ALUOp)

        // Load / Store
        2'b00:
            ALUControl = 4'b0000;

        // Branch
        2'b01:
            ALUControl = 4'b0001;

        // R-Type 
        2'b10:
        begin

            case(funct3)

                3'b000:
                begin
                    if(funct7 == 7'b0100000)
                        ALUControl = 4'b0001; // SUB
                    else
                        ALUControl = 4'b0000; // ADD
                end

                3'b111:
                    ALUControl = 4'b0010; // AND

                3'b110:
                    ALUControl = 4'b0011; // OR

                3'b100:
                    ALUControl = 4'b0100; // XOR

                3'b010:
                    ALUControl = 4'b0101; // SLT
                    
                3'b001: ALUControl = 4'b0110;   // SLL

               3'b101:
                begin
                  if(funct7 == 7'b0100000)
                  
                   ALUControl = 4'b1000;   // SRA
                      else
                      
                 ALUControl = 4'b0111;   // SRL
            end

          3'b011: ALUControl = 4'b1001;   // SLTU
      
                default:
                    ALUControl = 4'b0000;
                   
           endcase

        end
        
        2'b11:
begin
    case(funct3)

        3'b000: ALUControl = 4'b0000; // ADDI

        3'b111: ALUControl = 4'b0010; // ANDI

        3'b110: ALUControl = 4'b0011; // ORI

        3'b100: ALUControl = 4'b0100; // XORI

        3'b010: ALUControl = 4'b0101; // SLTI

        default: ALUControl = 4'b0000;

    endcase
end

        default:
            ALUControl = 4'b0000;

    endcase

end

endmodule
