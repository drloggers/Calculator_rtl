//-------------------------------------------
class uvmtb_display_key_monitor extends uvm_component;
	`uvm_component_utils(uvmtb_display_key_monitor)
	
/*************************************************************/
	uvm_analysis_port #(Alu_packet) mon_key_disp_ap;

	uvmtb_display_config disp_config; // Config object
	virtual Cal_bfm_if v_bfm_if;
	utils_functions utils;
/**************************************************************/

	function new( string name , uvm_component parent = null);
		super.new( name , parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase); //base class build  
		// get config object
		`uvm_info("BUILD", "building uvmtb_display_monitor",UVM_DEBUG);
		if(!(uvm_config_db #(uvmtb_display_config)::get(this, "","uvmtb_display_config",disp_config)))
			`uvm_fatal("CONFIG", "uvmtb_display_monitor : get(disp_config) error");
		v_bfm_if = disp_config.v_bfm_if; // assign local virtual interface
		// create ports
		mon_key_disp_ap = new("mon_key_disp_ap",this);
		`uvm_info("BUILD", "Finished building uvmtb_display_monitor",UVM_DEBUG);
		
		utils = new("utils",this);
	endfunction

	task run_phase(uvm_phase phase);
		Alu_packet result;
		`uvm_info("uvmtb_display_key_monitor", "Forever loop to read results started",UVM_DEBUG);
		forever begin
			result = Alu_packet::type_id::create("result");
			v_bfm_if.monitor_7seg(result.result,result.result_sign);
			result.result = utils.seg2bcd_4d(result.result);
			result.result = utils.bcd2int(result.result);
			`uvm_info("uvmtb_display_key_monitor", {"monitor 7 seg for keys",result.convert2string()},UVM_DEBUG);
			mon_key_disp_ap.write(result);
		end
		`uvm_info("uvmtb_display_key_monitor", "Forever loop to read results ended",UVM_DEBUG);
	endtask
		
endclass
