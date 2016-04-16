class uvmtb_keypad_agent extends uvm_component;
	`uvm_component_utils(uvmtb_keypad_agent);
/****************************************************************/
	uvm_analysis_port #(Key) mon_key_ap;
  
	uvmtb_keypad_driver kpad_drv;
	uvm_sequencer #(Key) seqr;
  
	uvmtb_keypad_monitor kpad_mon;  // keypad monitors
	uvmtb_keypad_config kpad_config; // Config object
/****************************************************************/
	function new( string name , uvm_component p);
		super.new( name , p );
	endfunction	

	 function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("BUILD", "building uvmtb_keypad_agent",UVM_DEBUG);
		// get config object
		if(!(uvm_config_db #(uvmtb_keypad_config)::get(this, "","uvmtb_keypad_config",kpad_config)))
			`uvm_fatal("uvmtb_KEYPAD_CONFIG", "uvmtb_keypad_agent : get(kpad_config) error");

		// create components
		mon_key_ap  = new("mon_key_ap",  this);
		kpad_mon  = uvmtb_keypad_monitor::type_id::create("kpad_mon", this);
		kpad_drv = uvmtb_keypad_driver::type_id::create("kpad_drv",this);
  
		seqr = new("seqr",this);
  
		kpad_config.seqr = seqr;
		`uvm_info("BUILD", "Finished building uvmtb_keypad_agent",UVM_DEBUG);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("CONNECT", "connecting components of uvmtb_keypad_agent",UVM_DEBUG);
		kpad_drv.seq_item_port.connect(seqr.seq_item_export);
		// connect up monitor analysis ports
		kpad_mon.mon_ap.connect(mon_key_ap);
		`uvm_info("CONNECT", "Finished connecting uvmtb_keypad_agent",UVM_DEBUG);
 endfunction
endclass