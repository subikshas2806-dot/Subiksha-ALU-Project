`timescale 1ns/1ps

module tb_alu;
    reg  [7:0] A, B;
    reg  [2:0] Sel;
    wire [7:0] Result;
    wire CarryOut, Zero;

    alu uut (
        .A(A),
        .B(B),
        .Sel(Sel),
        .Result(Result),
        .CarryOut(CarryOut),
        .Zero(Zero)
    );

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu);

        $display("Time  Sel  A    B    Result CarryOut Zero");
        $monitor("%4t  %b  %3d  %3d  %3d     %b       %b",
                 $time, Sel, A, B, Result, CarryOut, Zero);

        // Addition: 15 + 10 = 25
        A = 8'd15; B = 8'd10; Sel = 3'b000; #10;
        if (Result !== 8'd25 || CarryOut !== 1'b0 || Zero !== 1'b0)
            $display("FAIL: Addition"); else $display("PASS: Addition");

        // Subtraction: 20 - 5 = 15 (no borrow)
        A = 8'd20; B = 8'd5; Sel = 3'b001; #10;
        if (Result !== 8'd15 || CarryOut !== 1'b0 || Zero !== 1'b0)
            $display("FAIL: Subtraction"); else $display("PASS: Subtraction");

        // AND: 11001100 & 10101010 = 10001000
        A = 8'b11001100; B = 8'b10101010; Sel = 3'b010; #10;
        if (Result !== 8'b10001000 || CarryOut !== 1'b0 || Zero !== 1'b0)
            $display("FAIL: AND"); else $display("PASS: AND");

        // OR: 11001100 | 10101010 = 11101110
        A = 8'b11001100; B = 8'b10101010; Sel = 3'b011; #10;
        if (Result !== 8'b11101110 || CarryOut !== 1'b0 || Zero !== 1'b0)
            $display("FAIL: OR"); else $display("PASS: OR");

        // XOR: 11001100 ^ 10101010 = 01100110
        A = 8'b11001100; B = 8'b10101010; Sel = 3'b100; #10;
        if (Result !== 8'b01100110 || CarryOut !== 1'b0 || Zero !== 1'b0)
            $display("FAIL: XOR"); else $display("PASS: XOR");

        // Zero flag: 0 + 0 = 0
        A = 8'd0; B = 8'd0; Sel = 3'b000; #10;
        if (Result !== 8'd0 || CarryOut !== 1'b0 || Zero !== 1'b1)
            $display("FAIL: Zero flag"); else $display("PASS: Zero flag");

        // Addition overflow beyond 8 bits: 250 + 10 = 260 -> result 4, carry 1
        A = 8'd250; B = 8'd10; Sel = 3'b000; #10;
        if (Result !== 8'd4 || CarryOut !== 1'b1 || Zero !== 1'b0)
            $display("FAIL: Carry flag"); else $display("PASS: Carry flag");

        $display("Simulation finished.");
        $finish;
    end
endmodule
