class uvmtb_display_agent extends uvm_component;
	`uvm_component_utils(uvmtb_display_agent);
	
/****************************************************************/
	uvm_analysis_port #(Alu_packet) mon_result_ap;
	uvm_analysis_port #(Alu_packet) mon_key_disp_ap;
  
	uvmtb_display_driver disp_drv;
	
	uvmtb_display_monitor disp_mon;  // Display monitors
	uvmtb_display_key_monitor key_disp_mon;
	uvmtb_display_config disp_config; // Config object
/****************************************************************/

	function new( string name , uvm_component p);
		super.new( name , p );
	endfunction	

	 function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("BUILD", "building uvmtb_display_agent",UVM_DEBUG);
		// get config object
		if(!(uvm_config_db #(uvmtb_display_config)::get(this, "","uvmtb_display_config",disp_config)))
			`uvm_fatal("uvmtb_DISPLAY_CONFIG", "uvmtb_display_agent : get(disp_config) error");

		// create components
		mon_result_ap  = new("mon_result_ap",  this);
		mon_key_disp_ap  = new("mon_key_disp_ap",  this);
		disp_mon  = uvmtb_display_monitor::type_id::create("disp_mon", this);
		key_disp_mon  = uvmtb_display_key_monitor::type_id::create("key_disp_mon", this);
		disp_drv = uvmtb_display_driver::type_id::create("disp_drv",this);
    
		`uvm_info("BUILD", "Finished building uvmtb_display_agent",UVM_DEBUG);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("CONNECT", "connecting components of uvmtb_display_agent",UVM_DEBUG);
		// connect up monitor analysis ports
		disp_mon.mon_ap.connect(mon_result_ap);
		key_disp_mon.mon_key_disp_ap.connect(mon_key_disp_ap);
		`uvm_info("CONNECT", "Finished connecting uvmtb_display_agent",UVM_DEBUG);
 endfunction
endclass