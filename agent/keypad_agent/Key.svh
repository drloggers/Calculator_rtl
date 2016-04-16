class Key extends uvm_sequence_item;
	`uvm_object_utils(Key);

/*********************************************************/
	 int key;
/*********************************************************/
	
	function new( string name = "Key");
		super.new( name );
	endfunction
	
	function void do_copy(uvm_object rhs);
		Key key;
 
		if(!$cast(key, rhs)) begin
			`uvm_error("DO_COPY", $sformatf("Cast failed in %m"))
			return;
		end
		super.do_copy(rhs); // Chain the copy with parent classes
		this.key = key.key;
	endfunction: do_copy

	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		Key key;
 
		if(!$cast(key, rhs))
			return 0;
		
		return(super.do_compare(rhs, comparer) && (this.key == key.key));
	endfunction: do_compare

	function string convert2string();
		string s;
		s = super.convert2string();
		$sformat(s, "key: %0d",key);
		return s;
	endfunction: convert2string
endclass