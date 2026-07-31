`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 11:30:09
// Design Name: 
// Module Name: RegisterFile
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



module RegisterFile(

    input wire clk,
    input wire Reg_write,

    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,

    input wire [31:0] Write_data,

    output wire [31:0] Read_data1,
    output wire [31:0] Read_data2

);
reg [31:0] registers [0:31];
integer i;

initial begin
    for(i=0;i<32;i=i+1)
        registers[i]=32'd0;
end



assign Read_data1 = (rs1 == 0) ? 32'd0 : registers[rs1];

assign Read_data2 = (rs2 == 0) ? 32'd0 : registers[rs2];

always @(posedge clk)
begin

    if(Reg_write && rd != 0)
        registers[rd] <= Write_data;

end

endmodule


