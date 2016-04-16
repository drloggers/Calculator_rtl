module seg2BCD(input [7:0]leds, output reg[3:0]bcd);

  always @(leds)
		case (leds)      
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
//coverage never
			default: bcd = 4'd0;
		endcase

endmodule
