module mux_2x1_32bit (
    input [31:0] in1,
    input [31:0] in2,
    input  sel,
    output reg [31:0] out
);

    always @ (*) begin
        if (sel == 1'b0) begin
            out = in1;
        end else begin
            out = in2;
        end
    end
    
endmodule
