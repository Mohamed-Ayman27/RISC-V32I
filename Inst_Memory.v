module Inst_Memory (
    input [31:0] Address,
    output reg[31:0] ReadData
);
    reg[31:0] ROM[0:63];
    initial 
        $readmemh("Fact.txt", ROM);
    
    
	assign ReadData = ROM[ Address[31:2] ];
endmodule

