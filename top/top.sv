`timescale 10ns/10ns 
module top;
	import uvm_pkg::*;

	/*********************************************************/
	logic rst;
	// clk generation
	bit clk;
	/*********************************************************/

	initial
	 forever #50 clk = !clk;

	 initial begin
		rst = 0;
		repeat(2) @ (posedge clk) ;
		rst = 1;
	 end
	 
	// create interface & DUT
	Cal_bfm_if  calif (clk,rst);

	keypad kpad(.row(calif.rows),
				.col(calif.cols),
				.keyPressed(calif.key),
				.valid(calif.valid));
				
	calculator cal(.clk(calif.clk),
					.rst(calif.rst),
					.start(calif.start),
					.cols(calif.cols),
					.rows(calif.rows),
					.digit1(calif.digit1),
					.digit2(calif.digit2),
					.digit3(calif.digit3),
					.digit4(calif.digit4),
					.sign(calif.sign));

	initial begin
		uvm_config_db #(virtual Cal_bfm_if)::set(null,"*","Cal_bfm_if",calif); //set virtual interface
		// $monitor(" op1:%0h\t op2:%0h\t opr1:%0h\t data:%0h",top.cal.control_logic.operand1,top.cal.control_logic.operand2,top.cal.control_logic.operator,top.cal.control_logic.data);
	end
endmodule
