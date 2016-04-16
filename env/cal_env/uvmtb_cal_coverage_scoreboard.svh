//-------------------------------------------
class uvmtb_cal_coverage_scoreboard extends uvm_subscriber #(Alu_packet);
 `uvm_component_utils(uvmtb_cal_coverage_scoreboard)
 
/*********************************************************/
	 uvmtb_coverage_base coverage;
	 int txn_cnt;
	 real current_coverage;
	 int percentage_100_cnt;
	 bit percentage_100_met;
/*********************************************************/

	 function new( string name , uvm_component parent = null);
	  super.new( name , parent );
	 endfunction

	 function void build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   coverage = uvmtb_coverage_base::type_id::create("coverage");
	 endfunction

	 function void write(Alu_packet t);
	   txn_cnt++;
	   coverage.sample(t);
	   current_coverage = coverage.get_coverage();
	   if(current_coverage == 100 && !percentage_100_met) begin
		 percentage_100_cnt = txn_cnt;
		 percentage_100_met = 1;
	   end
	   `uvm_info("COVERAGE",$sformatf("%0d Packets sampled,  Coverage = %f%% ",
						txn_cnt,current_coverage), UVM_HIGH);
	 endfunction 
	 
	 function void report_phase(uvm_phase phase);
	  `uvm_info("COVERAGE","******************************************", UVM_MEDIUM);
	  `uvm_info("COVERAGE",$sformatf(" Final Coverage = %f%% ",current_coverage), UVM_MEDIUM );
	  if(percentage_100_met)
		`uvm_info("COVERAGE",$sformatf(" 100%% Coverage met with %0d transactions",percentage_100_cnt), UVM_MEDIUM);
	  `uvm_info("COVERAGE","******************************************\n", UVM_MEDIUM);
	 
	 endfunction

endclass
