class Result extends uvm_sequence_item;
	`uvm_object_utils(Result);
	
/*********************************************************/
	 int value;
	 bit sign;
/*********************************************************/
	
	function new( string name = "Result");
		super.new( name );
	endfunction
	
	function void do_copy(uvm_object rhs);
		Result result;
 
		if(!$cast(result, rhs)) begin
			`uvm_error("DO_COPY", $sformatf("Cast failed in %m"))
			return;
		end
		super.do_copy(rhs); // Chain the copy with parent classes
		this.value = result.value;
		this.sign = result.sign;
	endfunction: do_copy

	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		Result result;
 
		if(!$cast(result, rhs))
			return 0;
		
		return(super.do_compare(rhs, comparer) && (this.value == result.value) && (this.sign == result.sign));
	endfunction: do_compare

	function string convert2string();
		string s;
		s = super.convert2string();
		$sformat(s, "result: %0h :: sign:%0h",value,sign);
		return s;
	endfunction: convert2string
endclass