class utils_functions extends uvm_component;
	`uvm_component_utils(utils_functions);
	
	function new( string name , uvm_component parent = null);
		super.new( name , parent);
	endfunction
	
	function automatic void split_int(int number, ref int split1,ref int split2);
		split1 = 0;
		split2 = 0;
		
		split1 = number / 32'd10;
		split2 = number % 32'd10;
		
	endfunction
	
	function automatic logic[3:0] seg2bcd(logic[7:0] seg);
		logic [3:0] bcd;
		case (seg)      
			8'b0111_1110: bcd = 4'd0;
	   		8'b0011_0000: bcd = 4'd1;
			8'b0110_1101: bcd = 4'd2;
			8'b0111_1001: bcd = 4'd3;
			8'b0011_0011: bcd = 4'd4;
			8'b0101_1011: bcd = 4'd5;
			8'b0101_1111: bcd = 4'd6;
			8'b0111_0000: bcd = 4'd7;
			8'b0111_1111: bcd = 4'd8;
			8'b0111_1011: bcd = 4'd9;
			8'b0100_1111: bcd = 4'ha;  //  displays E
			8'b0000_0101: bcd = 4'hb;  //  displays r
			default: bcd = 4'd0;
		endcase
		return bcd;
	endfunction
   
	function bit[15:0] seg2bcd_4d(bit[31:0] seg);    // convert 4 digit 7 segment display to 4 digit Bcd
		bit[3:0] dig1,dig2,dig3,dig4;
		dig1 = seg2bcd(seg[31:24]);
		dig2 = seg2bcd(seg[23:16]);
		dig3 = seg2bcd(seg[15:8]);
		dig4 = seg2bcd(seg[7:0]);
 
		return ({dig1,dig2,dig3,dig4});
	endfunction
	
	function bit[15:0] bcd2bin(bit[15:0] bcd);
		return (bcd[15:12]* 10'd1000 + bcd[11:8] * 8'd100 +bcd[7:4] * 8'd10 + bcd[3:0]);
	endfunction
	
	function int bin2int(bit[15:0] bin);
		bit[15:0] binary_val = bin;
		int rem,base;
		int int_val;
		for(int i=0; i<16; i++) begin
			int_val = int_val + bin[i]* (2**i);
		end
		return (int_val);
	endfunction

	function int bcd2int(bit[15:0] bcd);
		bit[15:0] bin;
		bin = bcd2bin(bcd);
		return (bin2int(bin)); 
	endfunction
endclass