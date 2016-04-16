class uvmtb_kpad_predictor extends uvm_subscriber #(Key);
	`uvm_component_utils(uvmtb_kpad_predictor);

/*********************************************************/	
	 uvm_analysis_port #(Alu_packet) alu_result_ap;
	 Alu_packet pkt;
	 Alu_packet send_pkt;
	 bit operator_flag=0;
	 uvmtb_alu_golden_model golden_model;
	 
	 localparam single_digit_max_bcd = 8'd9;
/*********************************************************/
	 
	function new( string name = "uvmtb_kpad_predictor",uvm_component p );
		super.new( name ,p);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase); //base class build  
		alu_result_ap = new("alu_result_ap",this);
		pkt = Alu_packet::type_id::create("pkt");
		golden_model = uvmtb_alu_golden_model::type_id::create("golden_model", this);
	endfunction
	
	function void write(Key t);
		`uvm_info("uvmtb_kpad_predictor", {"predictor received : ",t.convert2string()},UVM_DEBUG);
			if (t.key > single_digit_max_bcd)  begin
				if (operator_flag) begin
					`uvm_info("uvmtb_kpad_predictor", $sformatf("operand2 build : %0d",pkt.operand2),UVM_DEBUG);
					operator_flag = '0;
					if(!$cast(pkt.operator2,t.key))
						`uvm_fatal("CAST_ERROR","operator 2 cast failed in uvmtb_kpad_predictor");
					`uvm_info("uvmtb_kpad_predictor", $sformatf("operator2 build : %0d",pkt.operator2),UVM_DEBUG);
					`uvm_info("uvmtb_kpad_predictor", "Calling golden_model",UVM_DEBUG);
					send_pkt = Alu_packet::type_id::create("send_pkt");
					send_pkt = golden_model.get_results(pkt);
					alu_result_ap.write(send_pkt);
					pkt = Alu_packet::type_id::create("pkt");
					`uvm_info("uvmtb_kpad_predictor", {"Packet Building done : \n",send_pkt.convert2string()},UVM_DEBUG);
				end
				else begin
					`uvm_info("uvmtb_kpad_predictor", $sformatf("operand1 build : %0d",pkt.operand1),UVM_DEBUG);
					operator_flag = '1;
					//key_q = {};
					if(!$cast(pkt.operator1,t.key))
						`uvm_fatal("CAST_ERROR","operator 1 cast failed in uvmtb_kpad_predictor");
					`uvm_info("uvmtb_kpad_predictor", $sformatf("operator1 build : %0d",pkt.operator1),UVM_DEBUG);
				end
			end
			else begin
				if(operator_flag) begin
					//key_q = {key_q,t.key};
					pkt.operand2 = pkt.operand2 * 8'd10 + t.key;
				end
				else begin
					//key_q = {key_q,t.key};
					pkt.operand1 = pkt.operand1 * 8'd10 +t.key;
				end
			end
	endfunction
endclass