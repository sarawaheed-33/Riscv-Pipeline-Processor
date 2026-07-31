`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2026 08:58:37 PM
// Design Name: 
// Module Name: riscv_pipeline_top
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




module riscv_pipeline_top(

    input clk,
    input rst

);
// Forwarding Unit Wires

wire [1:0] ForwardA;
wire [1:0] ForwardB;

// EX/MEM Stage Wires

wire [31:0] EX_MEM_ALUResult;
wire [31:0] EX_MEM_WriteData;
wire [31:0] EX_MEM_BranchTarget;
wire [4:0] EX_MEM_rd;
wire EX_MEM_RegWrite;
wire EX_MEM_MemRead;
wire EX_MEM_MemWrite;
wire [1:0] EX_MEM_ResultSrc;

// Memory Stage Wires

wire [31:0] MEM_ReadData;
wire [31:0] MEM_ALUResult;

// MEM/WB Stage Wires

wire [4:0] MEM_WB_rd;
wire MEM_WB_RegWrite;
wire [1:0] MEM_WB_ResultSrc;
wire [31:0] MEM_WB_ReadData;
wire [31:0] MEM_WB_ALUResult;

// IF Stage Wires

wire [31:0] pc;
wire [31:0] next_pc;
wire [31:0] instruction;
wire        PCSrc;
wire [31:0] BranchTarget;

// Hazard Signals

wire PCWrite;
wire IF_ID_Write;
wire Flush;

// IF/ID Pipeline Register

wire [31:0] IF_ID_PC;
wire [31:0] IF_ID_Instruction;
wire [31:0] IF_ID_PCPlus4;

// Instruction Fetch Stage

instruction_fetch IF_STAGE(

    .clk(clk),
    .rst(rst),

    .PCWrite(PCWrite),

    .pc_src(PCSrc),

    .branch_target(BranchTarget),

    .pc(pc),

    .pc_plus4(next_pc),

    .instruction(instruction)

);


// IF/ID Pipeline Register

pipeline_register
#(
    .WIDTH(96)
)
IF_ID(

    .clk(clk),

    .rst(rst),

    .stall(~IF_ID_Write),

    .flush(Flush),

    .d({pc,next_pc,instruction}),

    .q({IF_ID_PC,IF_ID_PCPlus4,IF_ID_Instruction})

);

// ID Stage Wires

wire [31:0] ReadData1;
wire [31:0] ReadData2;
wire [31:0] Immediate;

wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;

wire [2:0] funct3;
wire [6:0] funct7;
wire [6:0] opcode;

// Control Signals

wire RegWrite;
wire MemRead;
wire MemWrite;
wire ALUSrc;
wire Branch;
wire Jump;

wire [1:0] ResultSrc;
wire [1:0] ALUOp;

// Hazard Signals

wire Stall;

// Write Back Signals

wire WB_RegWrite;
wire [4:0] WB_rd;
wire [31:0] WB_WriteData;

instruction_decode ID_STAGE(

    .clk(clk),
    .rst(rst),

    .instruction(IF_ID_Instruction),
    .pc(IF_ID_PC),

    .reg_write(WB_RegWrite),
    .wb_rd(WB_rd),
    .wb_data(WB_WriteData),

    .read_data1(ReadData1),
    .read_data2(ReadData2),

    .immediate(Immediate),

    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),

    .funct3(funct3),
    .funct7(funct7),
    .opcode(opcode),

    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .Branch(Branch),
    .Jump(Jump),
    .ResultSrc(ResultSrc),
    .ALUOp(ALUOp),

    .stall(Stall)

);

wire ID_EX_MemRead;
wire [4:0] ID_EX_rd;

hazard_detection HAZARD(

    .MemRead_EX(ID_EX_MemRead),
    .rd_EX(ID_EX_rd),

    .rs1_ID(rs1),
    .rs2_ID(rs2),

    .branch_taken(PCSrc),
    .jump(Jump),

    .stall(Stall),
    .pc_write(PCWrite),
    .if_id_write(IF_ID_Write),
    .flush(Flush)

);
// EX Stage Wires
// Outputs of ID/EX Pipeline Register

wire [31:0] ID_EX_PC;
wire [31:0] ID_EX_ReadData1;
wire [31:0] ID_EX_ReadData2;
wire [31:0] ID_EX_Immediate;

wire [4:0] ID_EX_rs1;
wire [4:0] ID_EX_rs2;

wire [2:0] ID_EX_funct3;
wire [6:0] ID_EX_funct7;

wire ID_EX_RegWrite;
wire ID_EX_MemWrite;
wire ID_EX_ALUSrc;
wire ID_EX_Branch;
wire ID_EX_Jump;

wire [1:0] ID_EX_ResultSrc;
wire [1:0] ID_EX_ALUOp;

// Execute Outputs

wire [31:0] ALUResult;
wire [31:0] StoreData;
wire [31:0] EX_BranchTarget;

wire Zero;
wire [31:0] ID_EX_PCPlus4;
wire [194:0]ID_EX_BUS;
pipeline_register
#(
    .WIDTH(195)
)
ID_EX(

    .clk(clk),

    .rst(rst),

    .stall(1'b0),          // never stall ID/EX

    .flush(Flush | Stall), // insert bubble on hazard

//pack in ID/EX 
    .d({

        IF_ID_PC,
        IF_ID_PCPlus4,

        ReadData1,
        ReadData2,

        Immediate,

        rs1,
        rs2,
        rd,

        funct3,
        funct7,

        RegWrite,
        MemRead,
        MemWrite,
        ALUSrc,
        Branch,
        Jump,

        ResultSrc,

        ALUOp

    }),

    .q(ID_EX_BUS)

);
assign {

    ID_EX_PC,
    ID_EX_PCPlus4,
    ID_EX_ReadData1,
    ID_EX_ReadData2,
    ID_EX_Immediate,

    ID_EX_rs1,
    ID_EX_rs2,
    ID_EX_rd,

    ID_EX_funct3,
    ID_EX_funct7,

    ID_EX_RegWrite,
    ID_EX_MemRead,
    ID_EX_MemWrite,
    ID_EX_ALUSrc,
    ID_EX_Branch,
    ID_EX_Jump,

    ID_EX_ResultSrc,
    ID_EX_ALUOp

} = ID_EX_BUS;
forwarding_unit FORWARD(

    .rs1_EX(ID_EX_rs1),
    .rs2_EX(ID_EX_rs2),

    .rd_MEM(EX_MEM_rd),
    .RegWrite_MEM(EX_MEM_RegWrite),

    .rd_WB(MEM_WB_rd),
    .RegWrite_WB(MEM_WB_RegWrite),

    .ForwardA(ForwardA),
    .ForwardB(ForwardB)

);
execute EX_STAGE(

    .pc(ID_EX_PC),

    .read_data1(ID_EX_ReadData1),
    .read_data2(ID_EX_ReadData2),

    .immediate(ID_EX_Immediate),

    .funct3(ID_EX_funct3),
    .funct7(ID_EX_funct7),

    .ALUOp(ID_EX_ALUOp),
    .ALUSrc(ID_EX_ALUSrc),

    .ForwardA(ForwardA),
    .ForwardB(ForwardB),

    .EX_MEM_Data(EX_MEM_ALUResult),
    .MEM_WB_Data(WB_WriteData),

    .ALUResult(ALUResult),
    .WriteData(StoreData),

    .Zero(Zero),

    .BranchTarget(EX_BranchTarget)

);
assign PCSrc = (ID_EX_Branch & Zero) | ID_EX_Jump;

wire [31:0] EX_MEM_PCPlus4;
wire [137:0] EX_MEM_BUS;
pipeline_register
#(
    .WIDTH(138)
)
EX_MEM(

    .clk(clk),
    .rst(rst),

    .stall(1'b0),

    .flush(1'b0),

    .d({

        ALUResult,
        StoreData,

        EX_BranchTarget,

        ID_EX_rd,
        ID_EX_PCPlus4,

        ID_EX_RegWrite,
        ID_EX_MemRead,
        ID_EX_MemWrite,

        ID_EX_ResultSrc

    }),

    .q(EX_MEM_BUS)

);
// EX/MEM Wires


assign {
    
    EX_MEM_ALUResult,
    EX_MEM_WriteData,

    EX_MEM_BranchTarget,

    EX_MEM_rd,
    EX_MEM_PCPlus4,

    EX_MEM_RegWrite,
    EX_MEM_MemRead,
    EX_MEM_MemWrite,

    EX_MEM_ResultSrc

} = EX_MEM_BUS;

memory_stage MEM_STAGE(

    .clk(clk),

    .MemRead(EX_MEM_MemRead),
    .MemWrite(EX_MEM_MemWrite),

    .ALUResult(EX_MEM_ALUResult),

    .WriteData(EX_MEM_WriteData),

    .ReadData(MEM_ReadData),

    .ALUResultOut(MEM_ALUResult)

);
// MEM/WB Wires

wire [103:0] MEM_WB_BUS;

wire [31:0] MEM_WB_PCPlus4;

pipeline_register
#(
    .WIDTH(104)
)
MEM_WB(

    .clk(clk),

    .rst(rst),

    .stall(1'b0),

    .flush(1'b0),

    .d({

        MEM_ReadData,
        EX_MEM_PCPlus4,
        MEM_ALUResult,

        EX_MEM_rd,

        EX_MEM_RegWrite,

        EX_MEM_ResultSrc

    }),

    .q(MEM_WB_BUS)

);
assign {

    MEM_WB_ReadData,
    MEM_WB_PCPlus4,

    MEM_WB_ALUResult,

    MEM_WB_rd,

    MEM_WB_RegWrite,

    MEM_WB_ResultSrc

} = MEM_WB_BUS;

write_back WB_STAGE(

    .ResultSrc(MEM_WB_ResultSrc),

    .ReadData(MEM_WB_ReadData),

    .ALUResult(MEM_WB_ALUResult),

    .PCPlus4(MEM_WB_PCPlus4) ,      //  supporting JAL/JALR

    .WriteBackData(WB_WriteData)

);
assign WB_RegWrite = MEM_WB_RegWrite;

assign WB_rd = MEM_WB_rd;

assign BranchTarget = EX_BranchTarget;

endmodule