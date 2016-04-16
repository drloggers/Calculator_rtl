// **********************************
class uvmtb_sequence_single_digit_operation extends uvm_sequence #(Key);
  `uvm_object_utils(uvmtb_sequence_single_digit_operation);
/*********************************************************/
  int num_ops = 50;
/*********************************************************/
  function new(string name="uvmtb_sequence_single_digit_operation");
    super.new(name);
  endfunction
  
  task body();
    Alu_packet pkt;
	Key key;
	`uvm_info("SEQUENCE", "sequence uvmtb_sequence_single_digit_operation started",UVM_DEBUG);
	for (int cnt=0; cnt<num_ops;cnt++) begin
	
	/**************************************************************
	* operand 2 is greater
	**************************************************************/
		pkt = Alu_packet::type_id::create("pkt");
		key = Key::type_id::create("key");
		if(!pkt.randomize() with {operand2 == 99;operator1 inside {10};operand1 == 9;})
			`uvm_fatal("uvmtb_sequence_single_digit_operation","randomization error");

		`uvm_info("ALU_PACKET", pkt.convert2string(),UVM_DEBUG);
		gen_seq(pkt,key);
		
		pkt = Alu_packet::type_id::create("pkt");
		key = Key::type_id::create("key");
		if(!pkt.randomize() with {operand2 == 99;operator1 inside {11};operand1 == 9;})
			`uvm_fatal("uvmtb_sequence_single_digit_operation","randomization error");

		`uvm_info("ALU_PACKET", pkt.convert2string(),UVM_DEBUG);
		gen_seq(pkt,key);
		
		pkt = Alu_packet::type_id::create("pkt");
		key = Key::type_id::create("key");
		if(!pkt.randomize() with {operand2 == 99;operator1 inside {12};operand1 == 9;})
			`uvm_fatal("uvmtb_sequence_single_digit_operation","randomization error");

		`uvm_info("ALU_PACKET", pkt.convert2string(),UVM_DEBUG);
		gen_seq(pkt,key);
		
		pkt = Alu_packet::type_id::create("pkt");
		key = Key::type_id::create("key");
		if(!pkt.randomize() with {operand2 == 99;operator1 inside {13};operand1 == 9;})
			`uvm_fatal("uvmtb_sequence_single_digit_operation","randomization error");

		`uvm_info("ALU_PACKET", pkt.convert2string(),UVM_DEBUG);
		gen_seq(pkt,key);

	/**************************************************************
	* operand 1 is greater
	**************************************************************/
		pkt = Alu_packet::type_id::create("pkt");
		key = Key::type_id::create("key");
		if(!pkt.randomize() with {operand2 == 9;operator1 inside {10};operand1 == 99;})
			`uvm_fatal("uvmtb_sequence_single_digit_operation","randomization error");

		`uvm_info("ALU_PACKET", pkt.convert2string(),UVM_DEBUG);
		gen_seq(pkt,key);
		
		pkt = Alu_packet::type_id::create("pkt");
		key = Key::type_id::create("key");
		if(!pkt.randomize() with {operand2 == 9;operator1 inside {11};operand1 == 99;})
			`uvm_fatal("uvmtb_sequence_single_digit_operation","randomization error");

		`uvm_info("ALU_PACKET", pkt.convert2string(),UVM_DEBUG);
		gen_seq(pkt,key);
		
		pkt = Alu_packet::type_id::create("pkt");
		key = Key::type_id::create("key");
		if(!pkt.randomize() with {operand2 == 9;operator1 inside {12};operand1 == 99;})
			`uvm_fatal("uvmtb_sequence_single_digit_operation","randomization error");

		`uvm_info("ALU_PACKET", pkt.convert2string(),UVM_DEBUG);
		gen_seq(pkt,key);
		
		pkt = Alu_packet::type_id::create("pkt");
		key = Key::type_id::create("key");
		if(!pkt.randomize() with {operand2 == 9;operator1 inside {13};operand1 == 99;})
			`uvm_fatal("uvmtb_sequence_single_digit_operation","randomization error");

		`uvm_info("ALU_PACKET", pkt.convert2string(),UVM_DEBUG);
		gen_seq(pkt,key);		
	end
	`uvm_info("SEQUENCE", "sequence uvmtb_sequence_single_digit_operation ended",UVM_DEBUG);

  endtask
  
  task gen_seq(input Alu_packet pkt,input Key key);
  int num1, num2;
  /******************************************************************/
	//operand1
	split_int(pkt.operand1,num1,num2);
	start_item(key);
	key.key = num1;
	`uvm_info("KEY", key.convert2string(),UVM_DEBUG);
    finish_item(key);
	start_item(key);
	key.key = num2;
	`uvm_info("KEY", key.convert2string(),UVM_DEBUG);
    finish_item(key);
	/******************************************************************/
	/******************************************************************/
	//operator
	start_item(key);
	key.key = pkt.operator1;
	`uvm_info("KEY", key.convert2string(),UVM_DEBUG);
    finish_item(key);
	/******************************************************************/
	/******************************************************************/
	//operand2
	split_int(pkt.operand2,num1,num2);
	start_item(key);
	key.key = num1;
	`uvm_info("KEY", key.convert2string(),UVM_DEBUG);
    finish_item(key);
	start_item(key);
	key.key = num2;
	`uvm_info("KEY", key.convert2string(),UVM_DEBUG);
    finish_item(key);
	/******************************************************************/
	/******************************************************************/
	//operator
	start_item(key);
	key.key = pkt.operator2;
	`uvm_info("KEY", key.convert2string(),UVM_DEBUG);
    finish_item(key);
	/******************************************************************/
      
  endtask
  function automatic void split_int(int number, ref int split1,ref int split2);
	split1 = 0;
	split2 = 0;
	
	split1 = number / 32'd10;
	split2 = number % 32'd10;
	
  endfunction
endclass