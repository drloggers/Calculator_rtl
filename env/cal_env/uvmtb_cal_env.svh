//------------------------
// environment class
//
class uvmtb_cal_env extends uvm_env;
	`uvm_component_utils(uvmtb_cal_env)
 
 /*********************************************************/
	uvmtb_keypad_agent kpad_agent;
	uvmtb_display_agent disp_agent;
	uvmtb_kpad_predictor kpad_predictor;
	uvmtb_kpad_key_disp_predictor kpad_key_disp_predictor;
	uvmtb_alu_packet_scoreboard  result_sb;
	uvmtb_key_disp_scoreboard key_sb;
	uvmtb_cal_coverage_scoreboard cov_sb;
/*********************************************************/
 
	function new ( string name, uvm_component p);
		super.new(name, p);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase); //base class build
		`uvm_info("BUILD", "building uvmtb_cal_env",UVM_DEBUG);
		kpad_agent = uvmtb_keypad_agent::type_id::create("kpad_agent", this);
		disp_agent = uvmtb_display_agent::type_id::create("disp_agent", this);
		kpad_predictor = uvmtb_kpad_predictor::type_id::create("kpad_predictor", this);
		kpad_key_disp_predictor = uvmtb_kpad_key_disp_predictor::type_id::create("kpad_key_disp_predictor", this);
		result_sb = uvmtb_alu_packet_scoreboard::type_id::create("result_sb",this);
		key_sb = uvmtb_key_disp_scoreboard::type_id::create("key_sb",this);
		cov_sb = uvmtb_cal_coverage_scoreboard::type_id::create("cov_sb",this);
		`uvm_info("BUILD", "Finished building uvmtb_Cal_env",UVM_DEBUG);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("CONNECT", "connecting components in uvmtb_Cal_env",UVM_DEBUG);
		kpad_agent.mon_key_ap.connect(kpad_predictor.analysis_export);
		kpad_agent.mon_key_ap.connect(kpad_key_disp_predictor.analysis_export);
		
		//  Connect Scoreboards to router agent
		kpad_predictor.alu_result_ap.connect(result_sb.after_export);
		disp_agent.mon_result_ap.connect(result_sb.before_export);
		
		//  Connect Scoreboards to router agent
		kpad_key_disp_predictor.key_disp_ap.connect(key_sb.after_export);
		disp_agent.mon_key_disp_ap.connect(key_sb.before_export);
		
		// Connect coverage scoreboard
		kpad_predictor.alu_result_ap.connect(cov_sb.analysis_export);
		`uvm_info("CONNECT", "Finished connecting components in uvmtb_Cal_env",UVM_DEBUG);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		//kpad_predictor.set_report_id_verbosity( "WRITE", UVM_DEBUG );
	endfunction
endclass
