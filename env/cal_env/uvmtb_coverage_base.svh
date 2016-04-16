class uvmtb_coverage_base extends uvm_object;
  `uvm_object_utils(uvmtb_coverage_base)
  
  function new(string name = "uvmtb_coverage_base");
    super.new(name);
  endfunction


  virtual function void sample(Alu_packet txn);
  endfunction


  virtual function real get_coverage();
	return 0;
  endfunction

endclass