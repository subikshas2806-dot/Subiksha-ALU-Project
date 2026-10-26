8-bit ALU project starter
========================

Files:
- alu.v     : synthesizable 8-bit ALU module
- tb_alu.v  : simulation testbench with automatic PASS/FAIL checks
- report.pdf: project report

Simulation using Icarus Verilog:
1. Open a terminal in this folder.
2. Compile: iverilog -o alu_tb alu.v tb_alu.v
3. Run:     vvp alu_tb
4. Open waveform: gtkwave alu.vcd

Operation select:
000 Addition
001 Subtraction
010 AND
011 OR
100 XOR

Flag definition:
- Addition CarryOut is the 9th carry bit.
- Subtraction CarryOut follows the 9-bit direct-subtraction convention used in the supplied reference; for 20 - 5 it is 0.
- CarryOut is 0 for logical operations.
- Zero is 1 whenever Result is 0.

If your course specifically defines subtraction CarryOut differently, adjust the module/testbench to match that convention.
