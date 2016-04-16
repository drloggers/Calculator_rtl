// coverage never
class uvmtb_cal_coverage extends uvmtb_coverage_base;
	`uvm_object_utils(uvmtb_cal_coverage)
	
/*********************************************************/
	Alu_packet txn;
/*********************************************************/
  
  covergroup aluPacket;
   op1_cp: coverpoint txn.operand1 {
          bins op1_1dig    = {[0:9]};
	  bins op1_1dig_max= {9};
	  bins op1_1dig_min= {0};
	  bins op1_2dig    = {[10:99]};
	  bins op1_2dig_max= {99};
	  bins op1_2dig_min= {0};
       }
   op2_cp: coverpoint txn.operand2 {
          bins op2_1dig    = {[0:9]};
	  bins op2_1dig_max= {9};
	  bins op2_1dig_min= {0};
	  bins op2_2dig    = {[10:99]};
	  bins op2_2dig_max= {99};
	  bins op2_2dig_min= {0};
       }
   operation1: coverpoint txn.operator1 {
          bins opr1EC = (equal=>clear);
          bins opr1EE = (equal=>equal);
          bins opr1CC = (clear=>clear);
          bins opr1CE = (clear=>equal);
	  bins operationAdd = {10};
	  bins operationSub = {11};
	  bins operationMul = {12};
	  bins operationDiv = {13};
	  bins operationClear = {15};
       }
   operation2: coverpoint txn.operator2 {
          bins opt2EC = (equal=>clear);
          bins opt2EE = (equal=>equal);
          bins opt2CC = (clear=>clear);
          bins opt2CE = (clear=>equal);
	  bins operationAdd = {10};
	  bins operationSub = {11};
	  bins operationMul = {12};
	  bins operationDiv = {13};
	  bins operationClear = {15};
       }
   display1: coverpoint txn.result{
          bins disp1[10] = {[0:9]};
	  bins disp2[10] = {[10:19],[20:29],[30:39],[40:49],[50:59],[60:69],[70:79],[80:89],[90:99]};
	  bins disp3[10] = {[100:199],[200:299],[300:399],[400:499],[500:599],[600:699],[700:799],[800:899],[900:999]};
	  bins disp4[10] = {[1000:1999],[2000:2999],[3000:3999],[4000:4999],[5000:5999],[6000:6999],[7000:7999],[8000:8999],[9000:9999]};
       }
   operand1_less_than_operand2: coverpoint txn.operand1 < txn.operand2 { 
          bins hit = {1}; 
       }
   operand2_less_than_operand1: coverpoint txn.operand1 > txn.operand2 { 
          bins hits = {1};  
       }
   operations:cross op1_cp,op2_cp,operation1{
          bins one_dig_op_add = binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_1dig) && binsof(operation1.operationAdd);
	  bins one_dig_op_sub = binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_1dig) && binsof(operation1.operationSub);
	  bins one_dig_op_mul = binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_1dig) && binsof(operation1.operationMul);
	  bins one_dig_op_div = binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_1dig) && binsof(operation1.operationDiv);
	  
	  bins two_dig_op_add = binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_2dig) && binsof(operation1.operationAdd);
	  bins two_dig_op_sub = binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_2dig) && binsof(operation1.operationSub);
	  bins two_dig_op_mul = binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_2dig) && binsof(operation1.operationMul);
	  bins two_dig_op_div = binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_2dig) && binsof(operation1.operationDiv);
	  
	  bins one_or_two_dig_op_add = binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_2dig) && binsof(operation1.operationAdd);
	  bins one_or_two_dig_op_sub = binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_2dig) && binsof(operation1.operationSub);
	  bins one_or_two_dig_op_mul = binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_2dig) && binsof(operation1.operationMul);
	  bins one_or_two_dig_op_div = binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_2dig) && binsof(operation1.operationDiv);
	  
	  bins two_or_one_dig_op_add = binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_1dig) && binsof(operation1.operationAdd);
	  bins two_or_one_dig_op_sub = binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_1dig) && binsof(operation1.operationSub);
	  bins two_or_one_dig_op_mul = binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_1dig) && binsof(operation1.operationMul);
	  bins two_or_one_dig_op_div = binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_1dig) && binsof(operation1.operationDiv);
	  
	  bins div_divisor_smaller_than_divident = binsof(op1_cp.op1_2dig_max) && binsof(op2_cp.op2_1dig_max) && binsof(operation1.operationDiv);
	  bins div_divisor_greater_than_divident = binsof(op1_cp.op1_1dig_max) && binsof(op2_cp.op2_2dig_max) && binsof(operation1.operationDiv);
	  
	  bins sub_op1_smaller_than_op2 = binsof(op1_cp.op1_1dig_max) && binsof(op2_cp.op2_2dig_max) && binsof(operation1.operationSub);
	  bins sub_op1_greater_than_op2 = binsof(op1_cp.op1_2dig_max) && binsof(op2_cp.op2_1dig_max) && binsof(operation1.operationSub);
	  
	  bins add_op1_smaller_than_op2 = binsof(op1_cp.op1_1dig_max) && binsof(op2_cp.op2_2dig_max) && binsof(operation1.operationAdd);
	  bins add_op1_greater_than_op2 = binsof(op1_cp.op1_2dig_max) && binsof(op2_cp.op2_1dig_max) && binsof(operation1.operationAdd);
	  
	  bins mul_op1_smaller_than_op2 = binsof(op1_cp.op1_1dig_max) && binsof(op2_cp.op2_2dig_max) && binsof(operation1.operationMul);
	  bins mul_op1_greater_than_op2 = binsof(op1_cp.op1_2dig_max) && binsof(op2_cp.op2_1dig_max) && binsof(operation1.operationMul);
	  
	  bins div_0 = binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_1dig_min) && binsof(operation1.operationDiv);
	  bins mul_0 = binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_1dig_min) && binsof(operation1.operationMul);
	  bins sub_0 = binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_1dig_min) && binsof(operation1.operationSub);
	  bins add_0 = binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_1dig_min) && binsof(operation1.operationAdd);
	  
	  ignore_bins other = binsof(operation1.opr1EC) || binsof(operation1.opr1EE) || binsof(operation1.opr1CC) || binsof(op1_cp.op1_2dig_min)
	                      || binsof(operation1.opr1CE) || binsof(operation1.operationClear) || binsof(op2_cp.op2_2dig_min) || binsof(op1_cp.op1_1dig_min);
	  ignore_bins max_min_combinations_notused = ! binsof(op1_cp.op1_2dig_max) && binsof(op2_cp.op2_1dig_max) && binsof(operation1.operationSub) || 
	                                             ! binsof(op1_cp.op1_1dig_max) && binsof(op2_cp.op2_2dig_max) && binsof(operation1.operationSub) ||
	                                             ! binsof(op1_cp.op1_2dig_max) && binsof(op2_cp.op2_1dig_max) && binsof(operation1.operationDiv) ||
	                                             ! binsof(op1_cp.op1_1dig_max) && binsof(op2_cp.op2_2dig_max) && binsof(operation1.operationDiv) ||
	                                             ! binsof(op1_cp.op1_1dig_max) && binsof(op2_cp.op2_2dig_max) && binsof(operation1.operationAdd) ||
						     ! binsof(op1_cp.op1_2dig_max) && binsof(op2_cp.op2_1dig_max) && binsof(operation1.operationAdd) ||
						     ! binsof(op1_cp.op1_1dig_max) && binsof(op2_cp.op2_2dig_max) && binsof(operation1.operationMul) ||
						     ! binsof(op1_cp.op1_2dig_max) && binsof(op2_cp.op2_1dig_max) && binsof(operation1.operationMul) ||
	                                             ! binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_1dig_min) && binsof(operation1.operationDiv) ||
	                                             ! binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_1dig_min) && binsof(operation1.operationMul) ||
						     ! binsof(op1_cp.op1_2dig) && binsof(op2_cp.op2_1dig_min) && binsof(operation1.operationSub) ||
						     ! binsof(op1_cp.op1_1dig) && binsof(op2_cp.op2_1dig_min) && binsof(operation1.operationAdd) ||
						      binsof(op1_cp.op1_1dig_max) && binsof(op2_cp.op2_2dig) ||
						      binsof(op1_cp.op1_2dig_max) && binsof(op2_cp.op2_2dig) ||
						      binsof(op1_cp.op1_1dig_max) && binsof(op2_cp.op2_1dig) ||
						      binsof(op1_cp.op1_2dig_max) && binsof(op2_cp.op2_1dig);
       }
       option.auto_bin_max = 1;
   endgroup

	function new( string name = "uvmtb_cal_coverage");
		super.new( name );
		aluPacket = new();
	endfunction
	
  virtual function void sample(Alu_packet txn);
    this.txn = txn;
    aluPacket.sample();
  endfunction

  virtual function real get_coverage();
    return aluPacket.get_coverage();
  endfunction

endclass