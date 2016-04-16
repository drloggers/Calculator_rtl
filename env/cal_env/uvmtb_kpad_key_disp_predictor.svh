class uvmtb_kpad_key_disp_predictor extends uvm_subscriber #(Key);
	`uvm_component_utils(uvmtb_kpad_key_disp_predictor);

/*********************************************************/
	 uvm_analysis_port #(Alu_packet) key_disp_ap;
	 Alu_packet pkt;
	 Alu_packet send_pkt;
	 bit operator_flag=0;
	 
	 localparam single_digit_max_bcd = 8'd9;
/*********************************************************/
	 
	function new( string name = "uvmtb_kpad_key_disp_predictor",uvm_component p );
		super.new( name ,p);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase); //base class build  
		key_disp_ap = new("key_disp_ap",this);
		pkt = Alu_packet::type_id::create("pkt");
	endfunction
	
	function void write(Key t);
		`uvm_info("uvmtb_kpad_key_disp_predictor", {"key_disp_predictor received : ",t.convert2string()},UVM_DEBUG);
			if (t.key > single_digit_max_bcd)  begin
				pkt = Alu_packet::type_id::create("pkt");
				`uvm_info("uvmtb_kpad_key_disp_predictor", "Operator received, so creating new pkt data",UVM_DEBUG);
			end
			else begin
				pkt.result = pkt.result * 4'd10 + t.key;
				key_disp_ap.write(pkt);
				`uvm_info("uvmtb_kpad_key_disp_predictor", {"Key Display constructed : \n",pkt.convert2string()},UVM_DEBUG);
			end
	endfunction
endclass