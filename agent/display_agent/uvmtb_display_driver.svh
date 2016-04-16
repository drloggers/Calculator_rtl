class uvmtb_display_driver extends uvm_driver #(Result);
	`uvm_component_utils(uvmtb_display_driver);
/**************************************************************/
	uvmtb_display_config disp_config;
	virtual Cal_bfm_if v_bfm_if;
	
/**************************************************************/	
	function new( string name , uvm_component p);
		super.new( name , p );
	endfunction	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		// get config object
		`uvm_info("BUILD", "building uvmtb_display_driver",UVM_DEBUG);
		if(!(uvm_config_db #(uvmtb_display_config)::get(this, "","uvmtb_display_config",disp_config)))
			`uvm_fatal("CONFIG", "uvmtb_display_driver : get(disp_config) error");
	
		v_bfm_if = disp_config.v_bfm_if; // assign local virtual interface
   
		// create ports
  		`uvm_info("BUILD", "Finished building uvmtb_display_driver",UVM_DEBUG);
	endfunction

	virtual task run_phase(uvm_phase phase);
		
		`uvm_info("RUN", "Forever loop to write to display started",UVM_DEBUG);
		
		`uvm_info("RUN", "Forever loop to write to display ended",UVM_DEBUG);
	endtask
endclass