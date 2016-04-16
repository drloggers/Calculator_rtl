// configuration container class
class uvmtb_keypad_config extends uvm_object;
	`uvm_object_utils( uvmtb_keypad_config )
/*********************************************************/
	virtual Cal_bfm_if  v_bfm_if;
 
	uvm_sequencer #(Key) seqr;  // key agent sequencer
/*********************************************************/
 
	function new( string name = "uvmtb_keypad_config" );
		super.new( name );
	endfunction

endclass