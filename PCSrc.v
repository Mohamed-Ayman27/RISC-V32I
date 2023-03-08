module PCSrc (
    input ZF,
    input SF,
    input Branch,
    input[2:0] Funct3,
    output reg PCSrc
);
wire beq, bnq, blt;
    always @(*) begin
        case (Funct3)
            3'b000:  PCSrc <= Branch & ZF; 
            3'b001:  PCSrc <= Branch & ~ZF; 
            3'b100:  PCSrc <= Branch & SF; 
            default: PCSrc <= 1'b0;
        endcase
    end


    assign beq = Branch & ZF; 
    assign bnq = Branch & ~ZF; 
    assign blt = Branch & SF; 

endmodule