`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 13:27:01
// Design Name: 
// Module Name: Memory
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

module Memory #(
    parameter DATA_FILE = "Program.hex"
)(
    input  wire        Clk,
    input  wire [3:0]  WrEn,
    input  wire [31:0] Address,
    input  wire [31:0] WriteData,
    output wire [31:0] ReadData
);

RamSp #(
    .RAM_WIDTH(32),
    .RAM_ADDR_BITS(9),
    .DATA_FILE(DATA_FILE),
    .INIT_START_ADDR(0),
    .INIT_END_ADDR(255)
)
RAM (
    .Clk(Clk),
    .WrEn(WrEn),
    .Addr(Address[10:2]),
    .WrData(WriteData),
    .RdData(ReadData)
);

endmodule