`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 10:44:07 AM
// Design Name: 
// Module Name: riscv_tb
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


`timescale 1ns/1ps

module riscv_tb;

    //==================================================
    // Inputs
    //==================================================

    reg clk;
    reg rst;

    //==================================================
    // Instantiate DUT
    //==================================================

    riscv_pipeline_top DUT (
        .clk(clk),
        .rst(rst)
    );

    //==================================================
    // Clock Generation (10ns Period)
    //==================================================

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //==================================================
    // Reset
    //==================================================

    initial begin
        rst = 1;
        #20;
        rst = 0;
    end

    //==================================================
    // Header
    //==================================================

    initial begin
        $display("--------------------------------------------------------------------------------------------------------------------------------------------");
        $display("Time\tPC\t\tInstr\t\tEX_PC\t\tRD1\t\tRD2\t\tIMM\t\tALUSrc\tALUOp\tALUCtrl\tALUResult\tWB_RegWrite\tWB_rd\tWBData");
        $display("--------------------------------------------------------------------------------------------------------------------------------------------");
    end

    //==================================================
    // Display Every Clock
    //==================================================

    always @(posedge clk)
    begin
        if(!rst)
        begin
            $display("%0t\t%h\t%h\t%h\t%h\t%h\t%h\t%b\t%02b\t%04b\t%h\t%b\t\t%0d\t%h",

                $time,

                DUT.pc,
                DUT.instruction,

                DUT.ID_EX_PC,

                DUT.ID_EX_ReadData1,
                DUT.ID_EX_ReadData2,

                DUT.ID_EX_Immediate,

                DUT.ID_EX_ALUSrc,

                DUT.ID_EX_ALUOp,

                DUT.EX_STAGE.ALUControlSignal,

                DUT.ALUResult,

                DUT.WB_RegWrite,

                DUT.WB_rd,

                DUT.WB_WriteData
            );
        end
    end

    //==================================================
    // Finish Simulation
    //==================================================

    initial begin

        #500;
        $display("\nSimulation Finished Successfully");
        $finish;

    end

endmodule