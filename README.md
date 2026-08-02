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
