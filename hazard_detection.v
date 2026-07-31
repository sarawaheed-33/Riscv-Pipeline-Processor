`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 08:52:23 PM
// Design Name: 
// Module Name: hazard_detection
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

module hazard_detection(

    // From ID/EX stage
    input  wire        MemRead_EX,
    input  wire [4:0]  rd_EX,

    // From IF/ID stage
    input  wire [4:0]  rs1_ID,
    input  wire [4:0]  rs2_ID,

    // Branch/Jump control
    input  wire        branch_taken,
    input  wire        jump,

    // Outputs
    output reg         stall,
    output reg         pc_write,
    output reg         if_id_write,
    output reg         flush

);

always @(*) begin

    // Default values
    stall       = 1'b0;
    pc_write    = 1'b1;
    if_id_write = 1'b1;
    flush       = 1'b0;

    //==================================================
    // Load-Use Hazard Detection
    //==================================================
    if (MemRead_EX &&
        (rd_EX != 5'd0) &&
        ((rd_EX == rs1_ID) || (rd_EX == rs2_ID)))
    begin
        stall       = 1'b1;
        pc_write    = 1'b0;
        if_id_write = 1'b0;
    end

    //==================================================
    // Branch / Jump Flush
    //==================================================
    if (branch_taken || jump)
    begin
        flush = 1'b1;
    end

end

endmodule