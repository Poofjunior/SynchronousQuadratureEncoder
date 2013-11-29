/*****************************************************************************/
/*****************************************************************************/
/* quadratureEncoder is the top-level design entity of this project.
 * A call to Tools --> Netlist Viewers --> RTL Viewer (in Quartus II) should
 * display the overall module structure.
 */
module quadratureEncoder(  input logic clk, A, B, notReset, 
                          output logic [1:0] state,
                          output logic [4:0] count);
    EncoderParser EncInst0( 
                            .clk(clk), .A(A), .B(B), .notReset(notReset),
                            .state(state), .count(count)); 

endmodule
								  
