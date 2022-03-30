`default_nettype none

module fuckingKillMe();

    enum logic [2:0] {init, waitCoin, hold, load, waitForGuess, eval} currentState, nextState;

    always_ff @ (posedge clock)
        currentState <= nextState;

    always_comb begin
        case (currentState)
            init: begin
                if() nextState = waitCoin;
            end
            waitCoin: begin
                if(CoinInserted) nextState = hold;
                if(StartGame) nextState = load;
            end
            hold: begin
                if(~CoinInserted) nextState = waitCoin;
            end
            load: begin
            end
            waitForGuess: begin
                if(GradeIt) nextState = eval;
            end
            eval: begin
                if(~GradeIt) nextState = waitForGuess;
            end
        endcase
        if(reset) nextState = init;
    end

endmodule:
