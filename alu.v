`timescale 1ns/1ps

module alu (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [2:0] Sel,
    output reg  [7:0] Result,
    output reg        CarryOut,
    output wire       Zero
);

    reg [8:0] temp;

    always @(*) begin
        Result   = 8'b0;
        CarryOut = 1'b0;
        temp     = 9'b0;

        case (Sel)
            3'b000: begin
                temp     = {1'b0, A} + {1'b0, B};
                Result   = temp[7:0];
                CarryOut = temp[8];
            end

            3'b001: begin
                // Direct 9-bit subtraction, matching this project's reference convention.
                temp     = {1'b0, A} - {1'b0, B};
                Result   = temp[7:0];
                CarryOut = temp[8];
            end

            3'b010: Result = A & B;
            3'b011: Result = A | B;
            3'b100: Result = A ^ B;

            default: begin
                Result   = 8'b0;
                CarryOut = 1'b0;
            end
        endcase
    end

    assign Zero = (Result == 8'b0);

endmodule
