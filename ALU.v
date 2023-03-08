module ALU(
  input [31:0] SrcA,SrcB,
  input [2:0] sel,
  output reg [31:0] C,
  output reg ZF,SF,CF
);
always@(*)
	begin
  	case(sel)
   		3'b000 : C = SrcA + SrcB ;
   		3'b001 : C = SrcA<<SrcB ;
   		3'b010 : C = SrcA - SrcB ;
   		3'b100 : C = SrcA ^ SrcB ;
   		3'b101 : C = SrcA>>SrcB ;
   		3'b110 : C = SrcA | SrcB ;
   		3'b111 : C = SrcA & SrcB ;
   		default :C = 32'b0 ;
  	endcase  
	ZF = ~(|C);
	SF =  C[31];
end

endmodule

