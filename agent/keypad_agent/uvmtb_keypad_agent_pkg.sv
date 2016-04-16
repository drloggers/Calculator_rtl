package uvmtb_keypad_agent_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	typedef enum{add=10,sub=11,mul=12,div=13,equal=14,clear=15} operation;
	`include "Packet_base.svh"
	`include "Alu_packet.svh"
	`include "Key.svh"
	`include "uvmtb_keypad_config.svh"
	`include "uvmtb_keypad_driver.svh"
	`include "uvmtb_keypad_monitor.svh"
	`include "uvmtb_keypad_agent.svh"
endpackage