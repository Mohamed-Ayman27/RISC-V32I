<h1><b>RISC-V32I Processor</b></h1>
This repository contains the verilog code for a single-cycle RISC-V32I processor, which consists of the following modules:

Arithmetic Logic Unit (ALU)
Control unit, consisting of two parts:
Main decoder, which controls all signals in the processor
ALU decoder, which decodes instructions for the ALU
Program Counter (PC)
Instruction Memory
Data Memory
Sign Extension
Register File 32 x 32

<h2><b>Overview</b></h2>

The RISC-V32I processor is a simple, single-cycle processor that is capable of executing a subset of the RISC-V instruction set. The processor consists of several modules, each of which performs a specific function.

The main decoder controls all signals in the processor, including the ALU decoder. The ALU decoder decodes instructions for the ALU, which performs arithmetic and logical operations on the data.

The program counter keeps track of the current instruction address, while the instruction memory stores the instructions to be executed. The data memory stores data values used by the program.

The sign extension module extends 16-bit values to 32-bit values, and the register file provides 32 registers, each 32 bits wide.

<h2><b>Programs</b></h2>
The RISC-V32I processor has been tested with two programs: one that calculates the factorial of 8, and one that generates the Fibonacci series.

The factorial program uses a loop to compute the factorial of 8 (i.e., 8! = 40320). The Fibonacci program generates the first 10 numbers in the Fibonacci series (i.e., 0, 1, 1, 2, 3, 5, 8, 13, 21, 34).

<h2><b>Getting Started</b></h2>
To run the RISC-V32I processor, you will need to have a Verilog simulator installed, such as Icarus Verilog or ModelSim. Once you have a simulator installed, you can run the processor by compiling the Top_Module.v testbench file and running the resulting executable. If you want to run a different program in the instruction memory module change the $readmemh to the program you wrote make sure they are in the same directory.

<h2><b>Contributing</b></h2>
If you would like to contribute to this project, please feel free to submit a pull request or open an issue. Any contributions or feedback are greatly appreciated!

<h2><b>Acknowledgements</b></h2>
This project was inspired by the "Digital Design and Computer Architecture: RISC-V Edition" book by Sarah Harris and David Harris.





