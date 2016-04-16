/* This file is for testbench. It mimics the working of physical keypad and returns the row status based on the key pressed
*  Currently its 4x4 keypad. following is the layout:
*  	c0	c1	c2	c3	
*  	0	1	2	3	r0
*  	4	5	6	7	r1
*  	8	9	+	-	r2
*  	*	/	=	c	r3
*
*  	valid input gives the status of key pressed or unpressed
*  	valid = 1 --> key pressed
*  	valid = 0 --> key released  
*  	-- Sanket	
*/
`timescale 1 ns / 1 ns
module keypad #(parameter cols_count=4, parameter rows_count=4)
                (input [cols_count-1:0]col,input [3:0]keyPressed,input valid, 
                 output wire[rows_count-1:0] row );

  assign  row[0] = ((col == 4'd1 && keyPressed == 4'd12) || (col == 4'd2 && keyPressed == 4'd13) || (col == 4'd4 && keyPressed == 4'd14) || (col == 4'd8 && keyPressed == 4'd15)) && valid;
  assign  row[1] = ((col == 4'd1 && keyPressed == 4'd8) || (col == 4'd2 && keyPressed == 4'd9) || (col == 4'd4 && keyPressed == 4'd10) || (col == 4'd8 && keyPressed == 4'd11)) && valid; 
  assign  row[2] = ((col == 4'd1 && keyPressed == 4'd4) || (col == 4'd2 && keyPressed == 4'd5) || (col == 4'd4 && keyPressed == 4'd6) || (col == 4'd8 && keyPressed == 4'd7)) && valid; 
  assign  row[3] = ((col == 4'd1 && keyPressed == 4'd0) || (col == 4'd2 && keyPressed == 4'd1) || (col == 4'd4 && keyPressed == 4'd2) || (col == 4'd8 && keyPressed == 4'd3)) && valid; 

endmodule

