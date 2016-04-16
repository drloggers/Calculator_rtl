class test_base extends uvm_test;
	`uvm_component_utils(test_base)
	
/*********************************************************/
	uvmtb_cal_env cal_env;  // environment
	uvmtb_keypad_config kpad_config; // Config object
	uvmtb_display_config disp_config;
/*********************************************************/

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		// init cal config object
		kpad_config = new("kpad_config"); // create config object
		disp_config = new("disp_config"); // create config object
		
		`uvm_info("TEST_CONFIG","kpad_config created and calling get from config_db",UVM_DEBUG);
		
		if(!uvm_config_db #(virtual Cal_bfm_if)::get(this, "","Cal_bfm_if",kpad_config.v_bfm_if))  // get virtual interface container
			`uvm_fatal("CONFIG", "test_random: Config get error")
			
			
		if(!uvm_config_db #(virtual Cal_bfm_if)::get(this, "","Cal_bfm_if",disp_config.v_bfm_if))  // get virtual interface container
			`uvm_fatal("CONFIG", "test_random: Config get error")

		// write config object into config_db 
		uvm_config_db #(uvmtb_keypad_config)::set(this, "*", "uvmtb_keypad_config", kpad_config);
		uvm_config_db #(uvmtb_display_config)::set(this, "*", "uvmtb_display_config", disp_config);

		cal_env = uvmtb_cal_env::type_id::create("cal_env", this);
	endfunction
endclass