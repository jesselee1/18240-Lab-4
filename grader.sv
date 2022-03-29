`default_nettype none

module grader(
        input logic [11:0] masterPattern, Guess,
        input logic CLOCK_50, reset, GradeIt,
        output logic [3:0] Znarly, Zood);

    logic [3:0] znarly, zood;
    logic [11:0] master_pattern, guess;
    logic sel;

    graderFSM selFSM(.reset,.GradeIt,.sel,.clock(CLOCK_50));

    Register    pat(masterPattern, CLOCK_50, reset, GradeIt, master_pattern),
                gue(Guess, CLOCK_50, reset, GradeIt, guess);

    znarlyCalc  zna(.masterPattern(master_pattern),.Guess(guess), .znarly);
    zoodCalc    zoo(.masterPattern(master_pattern),.Guess(guess), .zood);

    Mux2to1 znar(znarly,4'b0000,sel,Znarly),
            znoo(zood,  4'b0000,sel,Zood  );

endmodule: grader

module graderFSM(
        input logic reset, GradeIt, clock,
        output logic sel);

    enum logic {grade = 1, ngrade = 0} sele,nsel;

    always_ff @ (posedge clock)
        sele <= nsel;

    always_comb begin
        if(GradeIt) nsel = grade;
        if(reset) nsel = ngrade;
        sel = sele;
    end

endmodule: graderFSM

module znarlyCalc(
        input logic [11:0] masterPattern, Guess,
        output logic [3:0] znarly);

    logic Zn1, Zn2, Zn3, Zn4;

    comparator  c1(masterPattern[11:9],Guess[11:9],Zn1),
                c2(masterPattern[8:6], Guess[8:6], Zn2),
                c3(masterPattern[5:3], Guess[5:3], Zn3),
                c4(masterPattern[2:0], Guess[2:0], Zn4);

    adder zsum(Zn1,Zn2,Zn3,Zn4,znarly);

endmodule: znarlyCalc

module zoodCalc(
        input logic [11:0] masterPattern, Guess,
        output logic [3:0] zood);

    logic   Zn1, Zn2, Zn3, Zn4,
            Zo1, Zo2, Zo3, Zo4, Zo5, Zo6,
            Zo7, Zo8, Zo9, Zo10, Zo11, Zo12,
            Zsel1, Zsel2, Zsel3, Zsel4,
            Zno1, Zno2, Zno3, Zno4;

    comparator  c1(masterPattern[11:9],Guess[11:9],Zn1),
                c2(masterPattern[8:6], Guess[8:6], Zn2),
                c3(masterPattern[5:3], Guess[5:3], Zn3),
                c4(masterPattern[2:0], Guess[2:0], Zn4);

    comparator  a1(masterPattern[11:9],Guess[8:6], Zo1),
                a2(masterPattern[11:9],Guess[5:3], Zo2),
                a3(masterPattern[11:9],Guess[2:0], Zo3),
                a4(masterPattern[8:6], Guess[11:9],Zo4),
                a5(masterPattern[8:6], Guess[5:3], Zo5),
                a6(masterPattern[8:6], Guess[2:0], Zo6),
                a7(masterPattern[5:3], Guess[11:9],Zo7),
                a8(masterPattern[5:3], Guess[8:6], Zo8),
                a9(masterPattern[5:3], Guess[2:0], Zo9),
                b1(masterPattern[2:0], Guess[11:9],Zo10),
                b2(masterPattern[2:0], Guess[8:6], Zo11),
                b3(masterPattern[2:0], Guess[5:3], Zo12);

    Or3to1  d1(Zo1,Zo2,Zo3,Zsel1),
            d2(Zo4,Zo5,Zo6,Zsel2),
            d3(Zo7,Zo8,Zo9,Zsel3),
            d4(Zo10,Zo11,Zo12,Zsel4);

    Mux2to1 #(1)    e1(Zsel1, 1'b0, ~Zn1, Zno1),
                    e2(Zsel2, 1'b0, ~Zn2, Zno2),
                    e3(Zsel3, 1'b0, ~Zn3, Zno3),
                    e4(Zsel4, 1'b0, ~Zn4, Zno4);

    adder f1(Zno1, Zno2, Zno3, Zno4, zood);

endmodule: zoodCalc

module comparator(
        input logic [2:0] A, B,
        output logic match);

    assign match = (A == B) ? 1 : 0;

endmodule: comparator

module adder(
        input logic A, B, C, D,
        output logic [3:0] sum);

    always_comb begin
        case ({A,B,C,D})
            4'b0000: sum = 4'd0;
            4'b0001: sum = 4'd1;
            4'b0010: sum = 4'd1;
            4'b0011: sum = 4'd2;
            4'b0100: sum = 4'd1;
            4'b0101: sum = 4'd2;
            4'b0110: sum = 4'd2;
            4'b0111: sum = 4'd3;
            4'b1000: sum = 4'd1;
            4'b1001: sum = 4'd2;
            4'b1010: sum = 4'd2;
            4'b1011: sum = 4'd3;
            4'b1100: sum = 4'd2;
            4'b1101: sum = 4'd3;
            4'b1110: sum = 4'd3;
            4'b1111: sum = 4'd4;
        endcase
    end

endmodule: adder

module Mux2to1
        #(parameter WIDTH = 4) (
        input logic [WIDTH-1:0] A, B,
        input logic sel,
        output logic [WIDTH-1:0] out);

    assign out = (sel) ? A : B;

endmodule: Mux2to1

module Or3to1(
        input logic A, B, C,
        output logic out);

    always_comb begin
        case ({A,B,C})
            3'b000: out = 0;
            default: out = 1;
        endcase
    end

endmodule: Or3to1

module Register(
        input logic [11:0] change,
        input logic clock, reset, en,
        output logic [11:0] store);

    always_ff @ (posedge clock) begin
        if (en) store <= change;
        if (reset) store <= 12'b0;
    end

endmodule: Register
