module BCD2binary #(parameter BCDdigits = 4)(input [BCDdigits*4-1:0] bcd,
                                             output reg [BCDdigits*4-1:0] binary);
 always @(bcd)begin
    binary = bcd[15:12]* 10'd1000 + bcd[11:8] * 8'd100 +bcd[7:4] * 8'd10 + bcd[3:0]; 
 end
endmodule
