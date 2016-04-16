
class cal_2ndOperand_equal_0_test extends test_base;
	`uvm_component_utils(cal_2ndOperand_equal_0_test)
	

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		// Replace coverage
		uvmtb_coverage_base::type_id::set_type_override(uvmtb_cal_coverage::get_type());
	endfunction
 
	function void end_of_elaboration_phase(uvm_phase phase);
			uvm_top.print_topology();
	endfunction
 
	task main_phase(uvm_phase phase);

		uvmtb_sequence_2ndOperand_equal_0 zero_seq = uvmtb_sequence_2ndOperand_equal_0::type_id::create("zero_seq");
		phase.raise_objection(this,"start random sequence");
    
		zero_seq.start(kpad_config.seqr);
		#1000us
		phase.drop_objection(this,"End random sequence");

	endtask
	
 
endclass
