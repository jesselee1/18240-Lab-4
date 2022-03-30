`default_nettype none

module arcadeChipInterface(
        input logic CLOCK_50,
        input logic [17:0] SW,
        input logic [3:0] KEY,
        output logic [7:0] VGA_R, VGA_G, VGA_B,
        output logic VGA_BLANK_N,VGA_CLK,VGA_SYNC_N,
        output logic VGAA_VS,VGA_HS,
        output logic [6:0] HEX0, HEX1, HEX2, HEX3,
        output logic [8:0] LEDG);

    logic clock, reset, coinInserted, StartGame, GradeIt, LoadShapeNow, GameWon, debug, clearGame;
    logic [1:0] CoinValue, ShapeLocation;
    logic [2:0] LoadShape;
    logic [3:0] Znarly, Zood, RoundNumber, NumGames, leftOver;
    logic [11:0] Guess, masterPattern;

    always_comb begin
        clock = CLOCK_50;
        coinInserted = ~KEY[1];
        reset = ~KEY[0];
        debug = SW[15];
        CoinValue = SW[17:15];
        GradeIt = ~KEY[3];
        LoadShapeNow = ~KEY[3];
        Guess = SW[11:0];
        LoadShape = SW[2:0];
        ShapeLocation = SW[4:3];
        StartGame = KEY[2];
    end

    Connector gameMod(.*);

    logic [3:0] BCD7, BCD6, BCD5, BCD4, BCD3, BCD2, BCD1, BCD0;
    logic [7:0] blank;
    logic [6:0] HEX7, HEX6, HEX5, HEX4;

    always_comb begin
        blank[7:5] = 3'b111;
        blank[4:0] = 5'b00000;
        BCD7 = 4'd0;
        BCD6 = 4'd0;
        BCD5 = 4'd0;
        BCD4 = leftOver;
        BCD3 = Znarly;
        BCD2 = Zood;
        BCD1 = RoundNumber;
        BCD0 = NumGames;
    end

    SevenSegmentDisplay ssd(.*);

    mastermindVGA mmvga(.numGames(NumGames),
                        .loadNumGames(1'b1),
                        .roundNumber(RoundNumber),
                        .guess(Guess),
                        .loadGuess(GradeIt),
                        .znarly(Znarly),
                        .zood(Zood),
                        .loadZnarlyZood(1'b1),
                        .displayMasterPattern(debug),
                        .*);

endmodule: arcadeChipInterface
