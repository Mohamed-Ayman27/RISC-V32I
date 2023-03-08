module ALU_Decoder (
    input[1:0] ALUOp,
    input[2:0] funct3,
    input funct7,
    input op5,
    output reg[2:0] ALUControl
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl <= 3'b000;

        2'b01:
            begin
                case (funct3)
                    3'b000: ALUControl <= 3'b010; 
                    3'b001: ALUControl <= 3'b010;
                    3'b100: ALUControl <= 3'b010;

                    default: ALUControl <= 3'b000;
                endcase
            end

        2'b10:
            begin
                case (funct3)
                    3'b000: 
                    begin
                        if ( {op5, funct7} != 2'b11 ) begin
                            ALUControl <= 3'b000;
                        end
                        else begin
                            ALUControl <= 3'b010;
                        end
                    end 
                    3'b001: ALUControl <= 3'b001;
                    3'b100: ALUControl <= 3'b100;
                    3'b101: ALUControl <= 3'b101;
                    3'b110: ALUControl <= 3'b110;
                    3'b111: ALUControl <= 3'b111;

                    default: ALUControl <= 3'b000;
                endcase
            end  
         
        default : ALUControl <= 3'b000 ;
    endcase
end

    
endmodule