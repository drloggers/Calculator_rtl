/* This modules controlls the alu and functionality of calculator. It converts the received numbers 
 * into binary and feeds it to alu unit with proper operator. the calculated result is again converted to BCD.
 * display output shows the entered numbers and the result. it does not show which operator is entered. 
 * The sign bit = 1 when the result is negative and = 0 when result is positive.
 * -- Sanket 
*/
`timescale 1 ns / 1 ns
module control_logic #(parameter BCDdigits=2)(input [3:0] data,
                                            input clk, rst, done,
                                            output reg ack,
                                            output reg [BCDdigits*4*2-1:0] display,
                                            output reg sign);
 
  typedef enum {start, receiveBCDdigits_set1, receiveOperation, receiveBCDdigits_set2, compute_and_continue, ack_BCDdigits_set1, ack_BCDdigits_set2, ack_operation} States_e;

  States_e state,nextState;
  reg [BCDdigits*4-1:0] operand1,operand2;
  reg [3:0] operator;
  reg op1_sign;
  wire [BCDdigits*4*2-1:0] op_bin1,op_bin2;
  wire [BCDdigits*4*2-1:0] op;
  wire op2_sign,alu_sign;

  reg [15:0] alu_op1,alu_op2;   // used for internal calculation of results
  reg [31:0] alu_result;
  reg [15:0] condt_result;
  
  assign condt_result = (alu_result > 32'd9999) ? '1:alu_result[15:0];
  assign op2_sign = '0;

  alu#(.BCDdigits(4)) alu(.operator(operator),.operand1(op_bin1),.operand2(op_bin2),.result(alu_result),.sign(alu_sign),.op1_sign(op1_sign),.op2_sign(op2_sign));  
  BCD2binary bb1(.bcd(alu_op1),.binary(op_bin1));
  BCD2binary bb2(.bcd(alu_op2),.binary(op_bin2));
  binary2BCD b2b(.binary(condt_result),.bcd(op));

  always_ff @(posedge clk) begin: rst_clk_blk
    if(!rst) begin
     state <= start;
    end
    else
      state <= nextState;
  end:rst_clk_blk

 always @(posedge clk) begin:fsm_logic
      case(state)
        start:   begin  ack <= '0;
                   operand1 <= '0;
                   operand2 <= '0;
                   operator <= '0;
                   alu_op1  <= '0;
                   alu_op2  <= '0; 
                   op1_sign <= '0;
		   
                 end
        receiveBCDdigits_set1: begin 
                            ack <= 1;
                            if(data <= 4'd9) begin  // BCD numbers are only from 0-9
                              operand1 <= {operand1[BCDdigits*4-4-1:0],data};  // shifting of one BCD digit to left to accept new number
                            end
                            sign <= 0;
                           end
        ack_BCDdigits_set1: 
                            begin 
                               ack <= 0;
                               alu_op1 <= operand1;
                               display <= operand1;
			   
                            end

        receiveOperation: begin
                           ack <= 1;
			
                           operator <= data[3:0];  // operator is always 4 bit number
                          end

        ack_operation: 
                       begin 
                          ack <= 0;
			
                       end

        receiveBCDdigits_set2: begin 
                           ack <= 1;
                         //  if(data <= 4'd9) begin
                             operand2 <= {operand2[BCDdigits*4-4-1:0],data};  // shifting of one BCD digit to left to accept new number
                        //   end

                           sign <= 0;
                         end
        ack_BCDdigits_set2: 
                            begin
                              ack <= 0;
			      sign <= 0;
                              display <= operand2;
                              alu_op2 <= operand2;
                            end

        compute_and_continue: begin 
                         ack <= 1;
                         if(data >=4'd9) begin  // operator are available from 10-13 (+ - * /)
                           if(op != 16'habb) alu_op1 <= op;
                           else alu_op1 <= 0;
                           op1_sign <= alu_sign;
                           operand2 <= '0;
                           alu_op2 <= '0;
                           operator <= data[3:0];
                           display <= op; 
			   sign <= alu_sign;
                         end
                   end
        
        endcase
  end:fsm_logic

  always_comb begin: always_comb_nextstate
    case(state)
         start:           if(done == 1) nextState = receiveBCDdigits_set1;
                          else nextState = start;

        receiveBCDdigits_set1: 
                          if (done == 1) nextState = ack_BCDdigits_set1;
                          else nextState = receiveBCDdigits_set1;

        ack_BCDdigits_set1: 
                         if(done == 1 && data <= 4'd9) 
                           nextState = receiveBCDdigits_set1;
                         else if (done == 1 && data <=4'd13) 
                           nextState = receiveOperation;
                         else if(done ==1)
                           nextState = start;
                         else nextState = ack_BCDdigits_set1;

        receiveOperation:
                          if(done == 1) nextState = ack_operation;
                          else nextState = receiveOperation;

        ack_operation: 
                     if(done==1)
                       nextState = receiveBCDdigits_set2;
                     else nextState = ack_operation;

        receiveBCDdigits_set2:
                          if (done == 1) nextState = ack_BCDdigits_set2;
                          else nextState = receiveBCDdigits_set2;

        ack_BCDdigits_set2:
                         if(done == 1 && data <= 4'd9) 
                           nextState = receiveBCDdigits_set2;
                         else if (done == 1 && data <= 4'd14) 
                           nextState = compute_and_continue;
                         else if(done ==1)
                           nextState = start;
                         else nextState = ack_BCDdigits_set2;

        compute_and_continue: if (data <= 4'd13)
                           nextState = ack_operation;
                         else if (done == 1)
                           nextState = start;
                         else nextState = compute_and_continue;
        
        default : nextState = start;       
        endcase
  end: always_comb_nextstate

endmodule

