module binary2BCD(input [15:0] binary,
                  output reg [15:0] bcd);

  reg[3:0] digit1,digit2,digit3,digit4;
 
  always @(binary) begin
   if(binary <= 16'h270f) begin  //number greater than bcd 9999
      digit1 = 0;
      digit2 = 0;
      digit3 = 0;
      digit4 = 0;
    for (int counter = 15; counter >= 0; counter = counter - 1) begin
     // if(digit1 >= 5)  digit1 = digit1 + 3;
      if(digit2 >= 5)  digit2 = digit2 + 3;
      if(digit3 >= 5)  digit3 = digit3 + 3;
      if(digit4 >= 5)  digit4 = digit4 + 3;

      digit1 = digit1 << 1;
      digit1[0] = digit2[3];
      digit2 = digit2 << 1;
      digit2[0] = digit3[3];
      digit3 = digit3 << 1;
      digit3[0] = digit4[3];
      digit4 = digit4 << 1;
      digit4[0] = binary[counter];  
    end
   bcd = {digit1,digit2,digit3,digit4};
  end
  else begin
  //  $display("binary number %d %h",binary,binary);
    bcd = {4'h0,4'ha,4'hb,4'hb};
  end
  end
endmodule
