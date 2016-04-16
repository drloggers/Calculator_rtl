// **********************************
class uvmtb_virtual_sequence extends uvm_sequence #(Key);
  `uvm_object_utils(uvmtb_virtual_sequence);

/****************************************************************/
  uvmtb_sequence_random 				rand_seq;
  uvmtb_sequence_2ndOperand_equal_0 	op2_0_seq;
  uvmtb_sequence_single_digit_operation single_digit_seq;
/****************************************************************/
  
  function new(string name="uvmtb_virtual_sequence");
    super.new(name);
  endfunction
  
  task body();
    rand_seq = uvmtb_sequence_random::type_id::create("rand_seq");
	op2_0_seq = uvmtb_sequence_2ndOperand_equal_0::type_id::create("op2_0_seq");
	single_digit_seq = uvmtb_sequence_single_digit_operation::type_id::create("single_digit_seq");
 
	rand_seq.start(null,this);
	op2_0_seq.start(null,this);
	single_digit_seq.start(null,this);

  endtask
  
endclass