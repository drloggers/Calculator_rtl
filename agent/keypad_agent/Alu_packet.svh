// coverage never
class Alu_packet extends Packet_base;
  `uvm_object_utils(Alu_packet);
  
  /*********************************************************/
  rand int operand1;
  rand int operand2;
  rand operation operator1;
  rand operation operator2;
  int result;
  bit result_sign;
  /*********************************************************/

  constraint operands {
    operand1 inside {[0:99]};
    operand2 inside {[0:99]};
   // operator1 inside {add,sub,div,mul};
	//operator2 inside {equal,clear};
  }
  
	function new( string name = "Alu_packet");
		super.new( name );
	endfunction
	
	function void do_copy(uvm_object rhs);
		Alu_packet ap;
 
		if(!$cast(ap, rhs)) begin
			`uvm_error("DO_COPY", "Cast failed in Alu_Packet");
			return;
		end
		super.do_copy(rhs); // Chain the copy with parent classes
		operand1 = ap.operand1;
		operand2 = ap.operand2;
		operator1 = ap.operator1;
		operator2 = ap.operator2;
		result = ap.result;
		result_sign = ap.result_sign;
	endfunction: do_copy

	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		Alu_packet ap;
 
		if(!$cast(ap, rhs))
			return 0;
		
		return((super.do_compare(rhs, comparer)) && (result == ap.result));
	endfunction: do_compare
	
	function string convert2string();
		string str;
		str = $sformatf("------ AluPacket id : %0d ------ \n",pkt_id);
		str ={ str, $sformatf("operand1  : %0d\noperator1 : %0s\noperand2  : %0d\nresult    : %0d\nsign  	:%d\noperator2 : %0s\n",operand1,operator1,operand2,result,result_sign,operator2)
         };
		str = {str , "--------------------------------" };
	
		return str;
	endfunction
  
	function void print();
		string str = convert2string();
		$display(str);
	endfunction
endclass
