`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 07:47:29 PM
// Design Name: 
// Module Name: pipeline_register
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

module pipeline_register #(
    parameter WIDTH = 32
)(
    input wire clk,
    input wire rst,
    input wire stall,
    input wire flush,
    input wire [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);

always @(posedge clk or posedge rst)
begin
    if (rst)
        q <= {WIDTH{1'b0}};

    else if (flush)
        q <= {WIDTH{1'b0}};

    else if (!stall)
        q <= d;

    // If stall = 1, retain previous value
end

endmodule
