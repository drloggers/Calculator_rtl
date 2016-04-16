class uvmtb_alu_golden_model extends uvm_component;
	`uvm_component_utils(uvmtb_alu_golden_model);

/*********************************************************/
	localparam max_cal_value = 9999;
	int exp_result;
	int loc_operand1;
	operation prev_op;
	bit contd_flag;
/*********************************************************/

	function new ( string name, uvm_component p);
		super.new(name, p);
	endfunction

	function Alu_packet get_results(Alu_packet txn);
		Alu_packet pkt = Alu_packet::type_id::create("pkt"); 
		pkt.do_copy(txn);
		if(contd_flag) begin
			exp_result = alu(loc_operand1, txn.operand1, prev_op);
	
			if(exp_result > max_cal_value || exp_result < -max_cal_value) begin 
				exp_result = 32'habb; // equivalent to Err on display
				exp_result = alu(0, txn.operand2, txn.operator1);
			end
			else begin
				exp_result = alu(exp_result, txn.operand2, txn.operator1);
			end
			if(txn.operator1 == equal || txn.operator1 == clear) begin
				exp_result = txn.operand2;
			end

			if(exp_result > max_cal_value || exp_result < -max_cal_value) 
				exp_result = 32'h0; // the result value created error
		end
		else begin
			exp_result = alu(txn.operand1, txn.operand2, txn.operator1);

			if(txn.operator1 == equal || txn.operator1 == clear) begin
				exp_result = txn.operand2;
			end
			if(exp_result > max_cal_value || exp_result < -max_cal_value) 
				exp_result = 32'habb; // equivalent to Err on display
		end

		if(txn.operator2 != equal) begin
			prev_op = txn.operator2;
			loc_operand1 = exp_result;
			contd_flag = 1;
		end
		else begin
			contd_flag = 0;
		end

		if((txn.operator1 == clear || txn.operator1 == equal) && (txn.operator2 == equal || txn.operator2 == clear))
			exp_result = 0;

		if(txn.operator2 == clear) begin
			prev_op = clear;
			loc_operand1 = 0;
			contd_flag = 0;
			exp_result = 0;
		end
		
		if(exp_result<0) begin
			pkt.result = 0-exp_result;
			pkt.result_sign = '1;
		end
		else
			pkt.result = exp_result;
		return (pkt);
	endfunction
	
	function int alu(int operand1, int operand2, operation operator);
		int result;
		case(operator)
			add: result = operand1 + operand2;
 
			sub: result = operand1 - operand2;
           
			mul: result = operand1 * operand2;

			div: begin
				if(operand2 == 0) exp_result = 0;
				else result = operand1 / operand2;
			end
		endcase
		return result;
	endfunction
endclass