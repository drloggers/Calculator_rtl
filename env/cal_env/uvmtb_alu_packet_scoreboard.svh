class uvmtb_alu_packet_scoreboard extends uvm_component;
	`uvm_component_utils(uvmtb_alu_packet_scoreboard)

/*********************************************************/
	// analysis exports
	uvm_analysis_export #(Alu_packet) before_export;
	uvm_analysis_export #(Alu_packet) after_export;

	// analysis fifo
	uvm_tlm_analysis_fifo #(Alu_packet) before_fifo, after_fifo;

	int m_matches, m_mismatches;
/*********************************************************/

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase ( uvm_phase phase);
		super.build_phase(phase);
		before_fifo = new ("before_fifo", this);
		after_fifo = new ("after_fifo", this);
		before_export = new ("before_export", this);
		after_export = new ("after_export", this);
	endfunction
	
	function void connect_phase (uvm_phase phase ); 
		super.connect_phase(phase);
		before_export.connect(before_fifo.analysis_export); // connect the before_export to the built-in analysis export of the before fifo
		after_export.connect(after_fifo.analysis_export); // connect the after_export to the built-in analysis export of the after fifo
	endfunction

	task run_phase (uvm_phase phase);
		string s;
		Alu_packet before_txn,after_txn;
		forever begin
			before_fifo.get(before_txn);
			after_fifo.get(after_txn);
			
			`uvm_info("uvmtb_alu_packet_scoreboard", {"Packet before_export : \n",before_txn.convert2string()},UVM_DEBUG);
			`uvm_info("uvmtb_alu_packet_scoreboard", {"Packet after_export : \n",after_txn.convert2string()},UVM_DEBUG);
			
			if (!before_txn.compare(after_txn)) begin
				`uvm_info("uvmtb_alu_packet_scoreboard", $sformatf ("%h does not match %h", before_txn.result, after_txn.result),UVM_DEBUG);
				`uvm_info("uvmtb_alu_packet_scoreboard", $sformatf ("Before: \n%s", before_txn.convert2string()),UVM_DEBUG);
				`uvm_info("uvmtb_alu_packet_scoreboard", $sformatf ("After: \n %s", after_txn.convert2string()),UVM_DEBUG);
				uvm_report_error ("uvmtb_alu_packet_scoreboard Mismatch", s);
				m_mismatches++;
			end
			else begin
				`uvm_info("uvmtb_alu_packet_scoreboard", $sformatf("Inside scoreboard: %h matches %h!", before_txn.result, after_txn.result),UVM_DEBUG);
				m_matches++;
			end
		end
	endtask


function void report_phase (uvm_phase phase );
  uvm_report_info ("uvmtb_alu_packet_scoreboard", "******************** Alu_packet Scoreboard ********************");
  uvm_report_info ("uvmtb_alu_packet_scoreboard", $sformatf ("\tMatches : %0d", m_matches));
  uvm_report_info ("uvmtb_alu_packet_scoreboard", $sformatf ("\tMismatches : %0d", m_mismatches));
  uvm_report_info ("uvmtb_alu_packet_scoreboard", $sformatf ("\tPercentage correct : %0d", m_matches * 100 /(m_matches+m_mismatches)));
  uvm_report_info ("uvmtb_alu_packet_scoreboard", "***************************************************************");
endfunction
 endclass