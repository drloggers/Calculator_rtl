module BCD2seg7 (input [3:0] bcd,
                 output reg [7:0]leds);
	
	always @(bcd)
		case (bcd)      
			4'h0: leds = 8'b0111_1110;
	   		4'h1: leds = 8'b0011_0000;
			4'h2: leds = 8'b0110_1101;
			4'h3: leds = 8'b0111_1001;
			4'h4: leds = 8'b0011_0011;
			4'h5: leds = 8'b0101_1011;
			4'h6: leds = 8'b0101_1111;
			4'h7: leds = 8'b0111_0000;
			4'h8: leds = 8'b0111_1111;
			4'h9: leds = 8'b0111_1011;
			4'ha: leds = 8'b0100_1111;  //  displays E
			4'hb: leds = 8'b0000_0101;  //  displays r
// coverage never
			default: leds = 8'b0000_0000;
		endcase
		
endmodule
