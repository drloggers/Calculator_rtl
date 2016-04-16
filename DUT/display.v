module display #(parameter BCDdigits = 2)(input [BCDdigits*4*2-1:0] display_data,
                                          output wire [7:0]seven_seg_data1,seven_seg_data2,seven_seg_data3,seven_seg_data4);

 BCD2seg7 disp1(.bcd(display_data[15:12]),.leds(seven_seg_data1));
 BCD2seg7 disp2(.bcd(display_data[11:8]),.leds(seven_seg_data2));
 BCD2seg7 disp3(.bcd(display_data[7:4]),.leds(seven_seg_data3));
 BCD2seg7 disp4(.bcd(display_data[3:0]),.leds(seven_seg_data4));

endmodule
