module Main_Decoder (
    input[6:0] OpCode,
    output reg RegWrite,
    output reg ALUSrc,
    output reg MemWrite,
    output reg ResultSrc,
    output reg Branch,
    output reg[1:0] ALUOp,
    output reg[1:0] ImmSrc
);
    always @(*) begin
        case (OpCode)
            7'b000_0011:                            //Load Word
                begin
                    RegWrite <=  1;
                    ImmSrc <= 2'b00;
                    ALUSrc <=    1;
                    MemWrite <=  0;
                    ResultSrc <= 1;
                    Branch <=    0;
                    ALUOp  <= 2'b00;
                end
            7'b010_0011:                            //Store Word
                begin
                    RegWrite <=  0;
                    ImmSrc <= 2'b01;
                    ALUSrc <=    1;
                    MemWrite <=  1;
                    ResultSrc <= 0;
                    Branch <=    0;
                    ALUOp <= 2'b00;
                end
            7'b011_0011:                            //R-Type
                begin
                    RegWrite <=  1;
                    ImmSrc <= 2'b00;
                    ALUSrc <=    0;
                    MemWrite <=  0;
                    ResultSrc <= 0;
                    Branch <=    0;
                    ALUOp <= 2'b10;
                end
            7'b001_0011:                            //I-Type
                begin
                    RegWrite <=  1;
                    ImmSrc <= 2'b00;
                    ALUSrc <=    1;
                    MemWrite <=  0;
                    ResultSrc <= 0;
                    Branch <=    0;
                    ALUOp <= 2'b10;
                end
            7'b110_0011:                            //Branch-Type
                begin
                    RegWrite <=  0;
                    ImmSrc <= 2'b10;
                    ALUSrc <=    0;
                    MemWrite <=  0;
                    ResultSrc <= 0;
                    Branch <=    1;
                    ALUOp <= 2'b01;
                end
            default:                                //Default
                begin
                    RegWrite <=  0;
                    ImmSrc <= 2'b00;
                    ALUSrc <=    0;
                    MemWrite <=  0;
                    ResultSrc <= 0;
                    Branch <=    0;
                    ALUOp <= 2'b00;
                end
        endcase
    end
endmodule