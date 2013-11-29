/*****************************************************************************/
/*****************************************************************************/
/* EncoderParser:
 * This module takes in the raw encoder inputs and outputs three values:
 * P and Pnot are toggled each time the encoder waveform changes.
 * Dir indicates the direction (clockwise or ccw).
 */
/*****************************************************************************/
/*****************************************************************************/
module EncoderParser( input logic  clk, A, B, notReset,
                     output logic [1:0]state, 
                     output logic [4:0] count);
// Internal logic:
logic [1:0]  prevState,  nextState; // should become a reg when compiled.
logic Anot, Bnot, cW, ccW, P, Pnot ; 
// States for the FSM:
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

// Generate internal logic signals:
    always @ (*) 
    begin
       Anot = ~A;
       Bnot = ~B; 
    end


// The Finite State Machine:

// next state logic: 
    always @ ( posedge clk) 
    begin
        state <= nextState;
        prevState <= state;
    end

// State transition logic:
    always @ (posedge clk)
    if (~notReset) count <= 5'b0;
    else
        begin
           case (state) 
                S0: nextState <= A     ?  S1 : 
                                 B     ?  S3 : S0 ; 
                S1: nextState <= B     ?  S2 : 
                                 Anot  ?  S0 : S1; 
                S2: nextState <= Anot  ?  S3 : 
                                 Bnot  ?  S1 : S2;
                S3: nextState <= Bnot  ?  S0 : 
                                 A     ?  S2 : S3 ;     
                //default nextState <= S0;
            endcase // no default?

// Add or decrement logic: 
    case ( {prevState, state})
        {S0, S1}:begin  count <= count + 1; end
        {S1, S2}:begin  count <= count + 1; end
        {S2, S3}:begin  count <= count + 1; end
        {S3, S0}:begin  count <= count + 1; end
        {S0, S3}:begin  count <= count - 1; end
        {S3, S2}:begin  count <= count - 1; end
        {S2, S1}:begin  count <= count - 1; end
        {S1, S0}:begin  count <= count - 1; end
        default
          begin count <= count; end
    endcase
    end

endmodule


