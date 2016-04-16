package uvmtb_test_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import uvmtb_env_pkg::*;
	import uvmtb_keypad_agent_pkg::*;
	import uvmtb_display_agent_pkg::*;
	import uvmtb_sequence_pkg::*;
		`include "test_base.svh"
		`include "cal_test.svh"
		`include "cal_single_digit_operation_test.svh"
		`include "cal_random_test.svh"
		`include "cal_2ndOperand_equal_0_test.svh"

endpackage
