interface Cal_bfm_if(input clk, input rst);

/*********************************************************/
 logic start=1'b1,valid=0;
 logic [3:0] key;
 logic [3:0] rows,cols; 
 logic [7:0] digit1,digit2,digit3,digit4;
 logic sign;
 
  localparam key_press_clk_delay = 10;
  localparam Error_code = 32'habb;
  localparam four_digit_max_bcd = 9999;
  localparam single_digit_max_bcd = 4'd9;
/*********************************************************/
  
  /*************************************************
  * drive method to preform key presses on keypad
  **************************************************/
  task automatic drive(input int key_temp);
   if(!$cast(key, key_temp))
		$display("key cast fail");
   valid = 1;
   repeat(key_press_clk_delay) @(posedge clk);
   valid = 0;
   repeat(key_press_clk_delay) @(posedge clk);
  endtask
  
  /*************************************************
  * monitor_keys method to send key presses on keypad
  **************************************************/
  task automatic monitor_keys(output bit[3:0] key_temp);
    key_temp = 0;
	 while(valid == 0) begin          // wait until key release happen
      @(posedge clk);
    end
    while(valid == 1) begin   	     // wait until valid(key press) is 1
      key_temp = key;
	  @(posedge clk);
    end
  endtask

  /*************************************************
  * monitor_results method to send results displayed on 7seg
  **************************************************/
  task automatic monitor_results(output bit[31:0] result, output bit r_sign);
	result = 0;
	r_sign = 0;
    repeat(key_press_clk_delay/3) @(posedge clk);
    while(key <= single_digit_max_bcd)  @(posedge clk);  // wait for 1st operator -> used only for operation
    while(key > single_digit_max_bcd)  @(posedge clk);  // 1st operator found
    while(key <= single_digit_max_bcd)  @(posedge clk);  // wait for 2nd operator -> produces the result
    while(key > single_digit_max_bcd)  @(negedge clk);  // 2nd operator found now use result
    result = {digit1,digit2,digit3,digit4};
    r_sign = sign;
  endtask

  /*************************************************
  * monitor_7seg method to send 7seg corresponding to key press(do not send when operator key is pressed)
  **************************************************/
  task automatic monitor_7seg(output bit[31:0] disp, output bit d_sign);
    while(valid == 0) begin   
      @(posedge clk);
    end
    while(valid == 1) begin   	     // wait until valid(key press) is 1
        @(posedge clk);
      if(key <= single_digit_max_bcd) begin
       disp = {digit1,digit2,digit3,digit4};
       d_sign = sign;
      end
      else begin
        while(valid == 1) begin   	     // wait until valid(key press) is 1
         @(posedge clk);
        end
        while(valid == 0) begin   	    
         @(posedge clk);
        end
      end
    end
  endtask
  
endinterface