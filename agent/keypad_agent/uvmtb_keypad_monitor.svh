//-------------------------------------------
class uvmtb_keypad_monitor extends uvm_component;
	`uvm_component_utils(uvmtb_keypad_monitor)
	
/*************************************************************/
	uvm_analysis_port #(Key) mon_ap;

	uvmtb_keypad_config kpad_config; // Config object
	virtual Cal_bfm_if v_bfm_if;
/**************************************************************/

	function new( string name , uvm_component parent = null);
		super.new( name , parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase); //base class build  
		// get config object
		`uvm_info("BUILD", "building uvmtb_keypad_monitor",UVM_DEBUG);
		if(!(uvm_config_db #(uvmtb_keypad_config)::get(this, "","uvmtb_keypad_config",kpad_config)))
			`uvm_fatal("CONFIG", "uvmtb_keypad_monitor : get(kpad_config) error");
		v_bfm_if = kpad_config.v_bfm_if; // assign local virtual interface
		// create ports
		mon_ap = new("mon_ap",this);
		`uvm_info("BUILD", "Finished building uvmtb_keypad_monitor",UVM_DEBUG);
	endfunction

	task run_phase(uvm_phase phase);
		Key key;
		`uvm_info("RUN", "Forever loop to read results started",UVM_DEBUG);
		forever begin
			key = Key::type_id::create("key");
			v_bfm_if.monitor_keys(key.key);
			mon_ap.write(key);
			`uvm_info("RUN", key.convert2string(),UVM_DEBUG);
		end  
		`uvm_info("RUN", "Forever loop to read results ended",UVM_DEBUG);
	endtask
   
endclass
