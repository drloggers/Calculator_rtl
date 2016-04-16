coverage exclude -src ./DUT/alu.sv -line 27-28
coverage exclude -src ./DUT/alu.sv -line 29-31
coverage exclude -src ./DUT/alu.sv -line 41-45
coverage exclude -src ./DUT/alu.sv -line 59-66
coverage exclude -src ./DUT/alu.sv -line 69-71
coverage exclude -src ./DUT/alu.sv -line 84-86
coverage exclude -src ./DUT/alu.sv -line 92-94
coverage exclude -src ./DUT/alu.sv -line 57-58
coverage exclude -src ./DUT/alu.sv -line 67-68
coverage exclude -src ./DUT/alu.sv -line 82-83
coverage exclude -src ./DUT/alu.sv -line 90-91
coverage exclude -src ./DUT/alu.sv -line 102-103
coverage exclude -src ./DUT/alu.sv -line 110-111
coverage exclude -src ./DUT/alu.sv -line 104-106
coverage exclude -src ./DUT/alu.sv -line 112-114
coverage exclude -du alu -togglenode {result[31:19]}
coverage exclude -du alu -togglenode op2_sign
coverage exclude -src ./DUT/control_logic.sv -line 135
coverage exclude -src ./DUT/control_logic.sv -line 122
coverage exclude -src ./DUT/keypad_scanner.sv -line 64-67
coverage exclude -src ./DUT/keypad_scanner.sv -line 89
coverage exclude -src ./DUT/control_logic.sv -line 161
coverage exclude -src ./DUT/control_logic.sv -line 159
coverage exclude -src ./DUT/control_logic.sv -line 144
coverage exclude -src ./DUT/keypad_scanner.sv -allfalse -line 25 -code b
coverage exclude -scope /top/cal/disp/disp1 -line 16-17 -code sb
coverage exclude -scope /top/cal/disp/disp2 -line 17 -code sb
coverage exclude -scope /top/cal/disp/disp3 -line 16 -code sb
coverage exclude -scope /top/cal/disp/disp4 -line 16 -code sb
coverage exclude -du BCD2seg7 -togglenode {leds[7]}
coverage exclude -du calculator -togglenode {digit1[7]}
coverage exclude -du calculator -togglenode {digit2[7]}
coverage exclude -du calculator -togglenode {digit3[7]}
coverage exclude -du calculator -togglenode {digit4[7]}
coverage exclude -du display -togglenode {seven_seg_data1[7]}
coverage exclude -du display -togglenode {seven_seg_data2[7]}
coverage exclude -du display -togglenode {seven_seg_data3[7]}
coverage exclude -du display -togglenode {seven_seg_data4[7]}
coverage exclude -du calculator -togglenode start
coverage exclude -du control_logic -togglenode {op_bin1[15:14]}
coverage exclude -du control_logic -togglenode {op_bin2[15:7]}
coverage exclude -du BCD2binary -togglenode {bcd[15:8]}
coverage exclude -du BCD2binary -togglenode {binary[15:7]}
coverage exclude -src ./DUT/control_logic.sv -allfalse -line 100 -code b
coverage exclude -src ./DUT/control_logic.sv -scope /top/cal/control_logic -allfalse -line 45 -code b
coverage exclude -du control_logic -finitial state start
coverage exclude -src ./DUT/alu.sv -feccondrow 23
coverage exclude -src ./DUT/alu.sv -feccondrow 98
coverage exclude -src ./DUT/alu.sv -feccondrow 78
coverage exclude -src ./DUT/alu.sv -feccondrow 47
coverage exclude -du calculator -togglenode rst
run -all
