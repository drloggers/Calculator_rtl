//coverage never
virtual class Packet_base extends uvm_sequence_item;
 `uvm_object_utils(Packet_base)
 
/*********************************************************/
  int pkt_id;
/*********************************************************/

	function new( string name = "Packet_base");
		super.new( name );
	endfunction
	
	function void do_copy(uvm_object rhs);
		Packet_base pb;
 
		if(!$cast(pb, rhs)) begin
			`uvm_error("DO_COPY", "Cast failed in Packet_base");
			return;
		end
		super.do_copy(rhs); // Chain the copy with parent classes
		pkt_id = pb.pkt_id;
	endfunction: do_copy

	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		Packet_base pb;
		if(!$cast(pb, rhs))
			return 0;
		
		return((super.do_compare(rhs, comparer)) && (pkt_id == pb.pkt_id));
	endfunction: do_compare

	function string convert2string();
		string s;
		s = super.convert2string();
		$sformat(s, "pkt_id: %0d",pkt_id);
		return s;
	endfunction: convert2string

  pure virtual function void print();
  
endclass
