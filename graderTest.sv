`default_nettype none

module grader_test();

    logic [11:0] masterPattern, Guess;
    logic reset, GradeIt, CLOCK_50;
    logic [3:0] Znarly, Zood;

    initial begin
        CLOCK_50 = 0;
        forever #5 CLOCK_50 = ~CLOCK_50;
    end

    grader gTest(.*);

    initial begin
        $monitor($time,,
            "masterPattern = %b, Guess = %b, GradeIt = %b, Znarly = %b, Zood = %b, reset = %b",
            masterPattern, Guess, GradeIt, Znarly, Zood, reset);
        /*$monitor($time,,
            "%b, %b, %b, %b, %b, %b, %b, %b, %b, %b, %b, %b | %b, %b, %b, %b",
            gTest.zoo.Zo1, gTest.zoo.Zo2, gTest.zoo.Zo3, gTest.zoo.Zo4, gTest.zoo.Zo5, gTest.zoo.Zo6, gTest.zoo.Zo7, gTest.zoo.Zo8,gTest.zoo.Zo9, gTest.zoo.Zo10,gTest.zoo.Zo11, gTest.zoo.Zo12, gTest.zoo.Zno1, gTest.zoo.Zno2, gTest.zoo.Zno3, gTest.zoo.Zno4);*/
            masterPattern <= 12'b101_010_010_110;
            Guess <= 12'b101_010_010_101;
            GradeIt <= 0;
            reset <= 0;
        @ (posedge CLOCK_50)
            GradeIt <= 1;
        @ (posedge CLOCK_50)
            Guess <= 12'b101_010_010_110;
        @ (posedge CLOCK_50)
            GradeIt <= 0;
        @ (posedge CLOCK_50)
            reset <= 1;
        @ (posedge CLOCK_50)
            reset <= 0;
            masterPattern <= 12'b101_111_110_011;
        @ (posedge CLOCK_50)
            Guess <= 12'b110_101_111_010;
            GradeIt <= 1;
        @ (posedge CLOCK_50)
            GradeIt <= 0;
        @ (posedge CLOCK_50)
            reset <= 1;
        @ (posedge CLOCK_50)
            reset <= 0;
        @ (posedge CLOCK_50)
            Guess <= 12'b101_110_010_010;
        @ (posedge CLOCK_50)
            GradeIt <= 1;
        @ (posedge CLOCK_50)
            GradeIt <= 0;
        @ (posedge CLOCK_50)
            reset <= 1;
        @ (posedge CLOCK_50)
            reset <= 0;
            masterPattern <= 12'b001_100_011_100;
        @ (posedge CLOCK_50)
            GradeIt <= 1;
        @ (posedge CLOCK_50)
            GradeIt <= 0;
        @ (posedge CLOCK_50)
            reset <= 1;
        @ (posedge CLOCK_50)
            reset <= 0;
            Guess <= 12'b111_001_100_011;
        @ (posedge CLOCK_50)
            GradeIt <= 1;
        @ (posedge CLOCK_50)
            GradeIt <= 0;
        @ (posedge CLOCK_50)
            reset <= 1;
        @ (posedge CLOCK_50)
            reset <= 0;
        @ (posedge CLOCK_50)
            masterPattern <= 12'b101_011_110_100;
            Guess <= 12'b011_011_011_011;
        @ (posedge CLOCK_50)
            GradeIt <= 1;
        @ (posedge CLOCK_50)
            GradeIt <= 0;
        @ (posedge CLOCK_50)
            $finish;
    end

endmodule: grader_test
/*
module adder_test();

    logic A,B,C,D;
    logic [3:0] sum;

    adder aTest(.*);

    initial begin
        $monitor($time,,
            "A = %b, B = %b, C = %b, D = %b, sum = %b",
            A, B, C, D, sum);
            A <= 0;
            B <= 0;
            C <= 0;
            D <= 0;
        #5  A <= 1;
        #5  B <= 1;
        #5  C <= 1;
        #5  D <= 1;
        #5  A <= 0;
            B <= 0;
        #5  C <= 0;
            D <= 0;
            A <= 1;
            B <= 1;
        #5  C <= 1;
            A <= 0;
        #5 $finish;
    end

endmodule: adder_test
*/
