module TopModule#(
    parameter Data_Size = 32,
    parameter Address_Bus = 5

) (
    input clk,
    input areset
);
    //Instruciton Memory
    wire[Data_Size-1 : 0] TOP_Instruciton,Top_InstAddress;

    //Control Unit Signals
    reg[6:0] TOP_OpCode;
    wire Top_RegWrite; 
    wire Top_ALUSrc;
    wire Top_MemWrite;
    wire Top_ResultSrc;
    wire Top_Branch;
    wire [1:0] Top_ALUOp;
    wire [1:0] Top_ImmSrc;                          

    //PC Signals
    wire Top_PCSrc;

    //Sign Extened Signal
    wire[Data_Size-1 : 0] TOP_ImmExt;

    //ALU Signals
    wire [Data_Size-1:0] TOP_RD1, TOP_RD2;
    wire [2:0] Top_ALUControl;
    wire [Data_Size-1:0] TOP_IN2, TOP_ALUResult;

    wire TOP_ZF,TOP_SF,TOP_CF;

    //Data Memory Signals
    wire[Data_Size-1:0] TOP_WD, TOP_RD;

    //Reg File Signals
    wire[Data_Size-1:0] TOP_WD3;



//Main Decoder
Main_Decoder TOP_Main_Decoder(
    .OpCode     (TOP_Instruciton[6:0]),
    .RegWrite   (Top_RegWrite),
    .ALUSrc     (Top_ALUSrc),
    .MemWrite   (Top_MemWrite),
    .ResultSrc  (Top_ResultSrc),
    .Branch     (Top_Branch),
    .ALUOp      (Top_ALUOp),
    .ImmSrc     (Top_ImmSrc)
);

//Sign Extension Unit
SignExtend TOP_SignExtention(
    .ImmExt     (TOP_ImmExt),
    .ImmSrc     (Top_ImmSrc),
    .Instr      (TOP_Instruciton)
);

//ALU Decoder unit
ALU_Decoder TOP_ALU_Decoder(
    .ALUOp      (Top_ALUOp),
    .funct3     (TOP_Instruciton[14:12]),
    .funct7     (TOP_Instruciton[30]),
    .op5        (TOP_OpCode[5]),
    .ALUControl (Top_ALUControl)
);

//Mux To choose the input either from B or an immediate
mux_2x1_32bit TOP_ALU_INPUT(
    .in1        (TOP_RD2),
    .in2        (TOP_ImmExt),
    .sel        ( Top_ALUSrc ),
    .out        (TOP_IN2)
);


//ALU Unit
ALU TOP_ALU(
  .SrcA     (TOP_RD1),
  .SrcB     (TOP_IN2),
  .sel      (Top_ALUControl),
  .C        (TOP_ALUResult),
  .ZF       (TOP_ZF),
  .SF       (TOP_SF),
  .CF       (TOP_CF)
);

//PSrc Calculation 
PCSrc TOP_PCSrc(
    .ZF     (TOP_ZF),
    .SF     (TOP_SF),
    .Branch (Top_Branch),
    .Funct3 (TOP_Instruciton[14:12]),
    .PCSrc  (Top_PCSrc)
);

//PC Unit
PC TOP_PC(
    .clk        (clk),
    .load       (1'b1),
    .areset     (areset),
    .ImmExt     (TOP_ImmExt),
    .PCSrc      (Top_PCSrc),
    .PC_out     (Top_InstAddress)
);

//Instruction Memory
Inst_Memory Top_InstMemory(
    .Address    (Top_InstAddress),
    .ReadData   (TOP_Instruciton)
);

//Mux to find the result of the Whole Session 
mux_2x1_32bit TOP_Result(
    .in1        (TOP_ALUResult),
    .in2        (TOP_RD),
    .sel        (Top_ResultSrc),
    .out        (TOP_WD3)
);


//Data Memory
Data_Memory TOP_DataMem(
    .clk        (clk),
    .WE         (Top_MemWrite),
    .Address    (TOP_ALUResult),
    .WriteData  (TOP_RD2),
    .ReadData   (TOP_RD)
);

//Reg File
Register_File TOP_RegFile(
    .WD3        (TOP_WD3),          		    //Write Data
    .A1         (TOP_Instruciton[19:15]),          //Adrress read 1
    .A2         (TOP_Instruciton[24:20]),          //address read 2
    .WE3        (Top_RegWrite),                    //Write enable
    .A3         (TOP_Instruciton[11:7]),          //Write Adress
    .clk        (clk),
    .areset     (areset),
    .RD1        (TOP_RD1),  			//Read data 1
    .RD2        (TOP_RD2)   			//Read data 2
);


endmodule
