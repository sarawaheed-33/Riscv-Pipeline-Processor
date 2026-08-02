# RISC-V Pipeline Processor

## 📖 Project Overview

This project implements a **5-stage pipelined RISC-V processor** in **Verilog HDL**. The processor executes RISC-V instructions using the classic pipeline stages and incorporates hazard detection and forwarding techniques to improve execution efficiency while maintaining correct program behavior.

The design was developed and simulated using **Xilinx Vivado** as part of a Computer Architecture project.

---

## ✨ Features

- 5-stage pipelined RISC-V processor
- Verilog HDL implementation
- Hazard Detection Unit
- Forwarding Unit
- Pipeline Registers
- Branch handling
- Instruction Fetch (IF)
- Instruction Decode (ID)
- Execute (EX)
- Memory Access (MEM)
- Write Back (WB)
- Simulation in Xilinx Vivado
![Block Diagram](images/block_diagram.png)
---

## 📐 RTL Schematic

The RTL schematic generated in Xilinx Vivado illustrates the structural organization of the pipelined processor and the interconnection of its hardware modules.

### RTL Schematic (Part 1)

![RTL Schematic Part 1](images/rtl_schematic-1.png)

### RTL Schematic (Part 2)

![RTL Schematic Part 2](images/rtl_schematic-2.png)
---

## 📊 Simulation Waveforms

The following simulation waveforms were generated using **Xilinx Vivado** to verify the functionality of the pipelined RISC-V processor. These waveforms demonstrate correct instruction execution, pipeline register operation, hazard handling, and write-back behavior.

### Waveform 1

![Waveform 1](images/waveform-1.png)

### Waveform 2

![Waveform 2](images/waveform-2.png)

### Waveform 3

![Waveform 3](images/waveform-3.png)

### Waveform 4

![Waveform 4](images/waveform-4.png)
---

## 📂 Project Structure

```text
RISCV-Pipeline-Processor/
│
├── images/                     # README images
├── ALU.v                       # Arithmetic Logic Unit
├── ALUControl.v                # ALU control logic
├── ControlUnit.v               # Main control unit
├── Data.hex                    # Data memory initialization
├── Program.hex                 # Instruction memory initialization
├── RamSp.sv                    # Single-port RAM
├── RegisterFile.v              # Register file
├── execute.v                   # Execute stage
├── forwarding_mux.v            # Forwarding multiplexer
├── forwarding_unit.v           # Data forwarding unit
├── hazard_detection.v          # Hazard detection unit
├── immediateGenerator.v        # Immediate value generator
├── instructionDecoder.v        # Instruction decoder
├── instruction_decode.v        # Instruction Decode stage
├── instruction_fetch.v         # Instruction Fetch stage
├── memory_stage.v              # Memory stage
├── pipeline_register.v         # Pipeline registers
├── programCounter.v            # Program counter
├── Memory.v                    # Data memory module
├── riscv_pipeline_top.v        # Top-level processor
├── riscv_tb.v                  # Testbench
├── write_back.v                # Write Back stage
└── README.md                   # Project documentation
```
