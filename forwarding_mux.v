`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 08:42:08 PM
// Design Name: 
// Module Name: forwarding_mux
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


module forwarding_mux(

    input wire [31:0] ReadData,
    input wire [31:0] EX_MEM_Data,
    input wire [31:0] MEM_WB_Data,
    input wire [1:0] ForwardSel,

    output reg [31:0] MuxOut

);

always @(*)
begin

    case(ForwardSel)

        2'b00: MuxOut = ReadData;

        2'b01: MuxOut = MEM_WB_Data;

        2'b10: MuxOut = EX_MEM_Data;

        default: MuxOut = ReadData;

    endcase

end

endmodule