package uvmtb_env_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import uvmtb_keypad_agent_pkg::*;
	import uvmtb_display_agent_pkg::*;
	`include "./cal_env/uvmtb_alu_golden_model.svh"
	`include "./cal_env/uvmtb_kpad_predictor.svh"
	`include "./cal_env/uvmtb_kpad_key_disp_predictor.svh"
	`include "./cal_env/uvmtb_alu_packet_scoreboard.svh"
	`include "./cal_env/uvmtb_key_disp_scoreboard.svh"
	`include "./cal_env/uvmtb_coverage_base.svh"
	`include "./cal_env/uvmtb_cal_coverage.svh"
	`include "./cal_env/uvmtb_cal_coverage_scoreboard.svh"
	`include "./cal_env/uvmtb_cal_env.svh"
endpackage