/* Alu unit performs addition, subtraction, multiplication and division
 * This also handles negative results and sign bit is used to show if the result is negative.
 * sign = 1 --> result is negative
 * sign = 0 --> result is positive
 * This unit also handles divide by zero error, by returning 0 as result.
 * --Sanket 
*/
module alu #(parameter BCDdigits=2)(           input [3:0]operator,
					       input bit op1_sign,
					       input bit op2_sign,
                                               input [BCDdigits*4-1:0] operand1,operand2,
                                               output reg [BCDdigits*4*2-1:0]result,
                                               output reg sign);
  parameter plus     = 4'd10;
  parameter subtract = 4'd11;
  parameter mul      = 4'd12;
  parameter div      = 4'd13;

  always_comb begin
     sign = 0;
     case(operator) 
        plus: begin
             if(op1_sign == 0 && op2_sign == 0) begin
	     result =  operand1 + operand2;
             sign = 0;
	     end
	     else if(op1_sign == 0 && op2_sign == 1) begin
	     result =  operand1 - operand2;
             sign = 0;
	     end
	     else if(op1_sign == 1 && op2_sign == 0) begin
	       if (operand1 < operand2) begin
	         result =  operand2 - operand1;
                 sign = 0;
	       end
	       else begin
	         result = operand1 - operand2;
	         sign = 1;
	       end
	       end
	     else begin
	     result =  operand1 + operand2;
             sign = 1;
	     end
            end
        subtract: begin
             if(op1_sign == 0 && op2_sign == 0) begin
	      if (operand1 < operand2) begin
               result = operand2 - operand1;
               sign = 1;
             end
             else begin
               result = operand1 - operand2;
               sign = 0;
             end
             end
            else if(op1_sign == 1 && op2_sign == 1) begin
	      if (operand1 < operand2) begin
               result = operand2 - operand1;
               sign = 0;
             end
             else begin
               result = operand1 - operand2;
               sign = 1;
             end
             end
            else if(op1_sign == 0 && op2_sign == 1) begin
	       result = operand1 + operand2;
               sign = 0;
            end
            else begin
	       result = operand1 + operand2;
               sign = 1;
             end
             
            end
        mul: begin
             if(op1_sign == 0 && op2_sign == 0) begin
	      result =  operand1 * operand2;
              sign = 0;
	     end
	     else if(op1_sign == 0 && op2_sign == 1) begin
	     result =  operand1 * operand2;
             sign = 1;
	     end
	     else if(op1_sign == 1 && op2_sign == 0) begin
	     result =  operand1 * operand2;
             sign = 1;
	     end
	     else begin
	     result =  operand1 * operand2;
             sign = 0;
	     end
            end
        div: begin
               if(operand2 == 0) result = 0;     // divide by zero produces 0 as result
               else  begin
             if(op1_sign == 0 && op2_sign == 0) begin
	      result =  operand1 / operand2;
              sign = 0;
	     end
	     else if(op1_sign == 0 && op2_sign == 1) begin
	     result =  operand1 / operand2;
             sign = 1;
	     end
	     else if(op1_sign == 1 && op2_sign == 0) begin
	     result =  operand1 / operand2;
             sign = 1;
	     end
	     else begin
	     result =  operand1 / operand2;
             sign = 0;
	     end
	       end
            end
        default: begin 
	          result = 0;
		  sign = 0;
		 end
      endcase

  end
 
endmodule
