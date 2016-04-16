// **********************************
class uvmtb_sequence_random extends uvm_sequence #(Key);
  `uvm_object_utils(uvmtb_sequence_random);

  int num_ops = 1500;
  
  function new(string name="uvmtb_sequence_random");
    super.new(name);
  endfunction
  
  task body();
    Alu_packet pkt;
	Key key;
	int num1, num2;
	`uvm_info("SEQUENCE", "sequence started",UVM_DEBUG);
    for (int count=0;count<num_ops;count++) begin
      pkt = Alu_packet::type_id::create("pkt");
	  key = Key::type_id::create("key");
      if(!pkt.randomize())
		`uvm_fatal("uvmtb_sequence_random","randomization error");

	`uvm_info("ALU_PACKET", pkt.convert2string(),UVM_DEBUG);
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
	pkt.pkt_id = count;
      
    end
	`uvm_info("SEQUENCE", "sequence ended",UVM_DEBUG);
  endtask
  
  function automatic void split_int(int number, ref int split1,ref int split2);
	split1 = 0;
	split2 = 0;
	
	split1 = number / 32'd10;
	split2 = number % 32'd10;
	
  endfunction
endclass