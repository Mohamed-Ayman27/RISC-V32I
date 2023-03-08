module Register_File(
  input clk, areset,           // clock and asynchronous reset inputs
  input [4:0] A1,              // read address 1 input
  input [4:0] A2,              // read address 2 input
  input [4:0] A3,              // write address input
  input [31:0] WD3,            // data input for write address
  input WE3,                   // write enable for write address
  output reg [31:0] RD1,       // data output for read address 1
  output reg [31:0] RD2        // data output for read address 2
);

reg [31:0] registers [31:0];   // an array of 32 registers, each with 32 bits
integer i;
always @(posedge clk or negedge areset) begin
  if (!areset) begin
    // Asynchronous reset, all registers are reset to 0
    for ( i = 0; i < 32; i = i + 1) begin
      registers[i] <= 0;
    end
  end
  else begin
    // On a clock edge, check the write address and write the data to the corresponding register
    if (WE3) begin
      if (A3 < 32) begin
        registers[A3] <= WD3;
      end
    end
  end
end

// Read data from the registers for the two read addresses
assign  RD1 = (A1 < 32) ? registers[A1] : 0;
assign  RD2 = (A2 < 32) ? registers[A2] : 0;

endmodule
