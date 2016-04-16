class uvmtb_keypad_driver extends uvm_driver #(Key);
	`uvm_component_utils(uvmtb_keypad_driver);
/**************************************************************/
	uvm_analysis_port #(Key) kpad_broadcast_ap;
	uvmtb_keypad_config kpad_config;
	virtual Cal_bfm_if v_bfm_if;
	
/**************************************************************/	
	function new( string name , uvm_component p);
		super.new( name , p );
	endfunction	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		// get config object
		`uvm_info("BUILD", "building uvmtb_keypad_driver",UVM_DEBUG);
		if(!(uvm_config_db #(uvmtb_keypad_config)::get(this, "","uvmtb_keypad_config",kpad_config)))
			`uvm_fatal("CONFIG", "uvmtb_keypad_driver : get(keypad_config) error");
	
		v_bfm_if = kpad_config.v_bfm_if; // assign local virtual interface
   
		// create ports
  		kpad_broadcast_ap = new("kpad_broadcast_ap",this);
		`uvm_info("BUILD", "Finished building uvmtb_keypad_driver",UVM_DEBUG);
	endfunction

	virtual task run_phase(uvm_phase phase);
		Key key;
		`uvm_info("RUN", "Forever loop to write to keypad started",UVM_DEBUG);
		forever begin
			seq_item_port.get_next_item(key);
			v_bfm_if.drive( key.key);
			kpad_broadcast_ap.write(key);  // broadcast txn
			`uvm_info("RUN", key.convert2string(),UVM_DEBUG);
			seq_item_port.item_done();
		end
		`uvm_info("RUN", "Forever loop to write to keypad ended",UVM_DEBUG);
	endtask
endclass