module Data_Memory (
    input clk,
    input WE,
    input[31:0] Address,
    input[31:0] WriteData,
    output wire[31:0] ReadData,
    output reg[31:0] Data_Out
);
    reg[31:0]mem[0:63];

    always @(posedge clk) begin
        if(WE)begin
            mem[Address] <= WriteData;
        end
        else begin
            mem[Address]<=mem[Address];
        end
    end
	assign ReadData = mem[Address];
endmodule
