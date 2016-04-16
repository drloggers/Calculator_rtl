/* this module is specifically designed for the 4x4 keypad. It takes the data
 * in form of rows-colunms and returns the Decimal encoded value.
 * here 10 --> +
 * 11 --> -
 * 12 --> *
 * 13 --> /
 * 14 --> =
 * 15 --> Clear
 * --Sanket
 */
module keypad_encoder_4x4(input [7:0]data,output reg [3:0] encode_data);
 
  always @(data) begin
    case(data)
      8'h81: encode_data = 4'd0;
      8'h82: encode_data = 4'd1;
      8'h84: encode_data = 4'd2;
      8'h88: encode_data = 4'd3;
      8'h41: encode_data = 4'd4;
      8'h42: encode_data = 4'd5;
      8'h44: encode_data = 4'd6;
      8'h48: encode_data = 4'd7;
      8'h21: encode_data = 4'd8;
      8'h22: encode_data = 4'd9;
      8'h24: encode_data = 4'd10;
      8'h28: encode_data = 4'd11;
      8'h11: encode_data = 4'd12;
      8'h12: encode_data = 4'd13;
      8'h14: encode_data = 4'd14;
      8'h18: encode_data = 4'd15;
      default: encode_data = 4'd0;
  endcase
 end

 
endmodule
