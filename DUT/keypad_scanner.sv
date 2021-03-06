/*  keypad scanner: scans the keypad and detect the key pressed.
 *   If no key is pressed, output is always all 1's else returns correct 8 bit data.
 *  done = 1 --> the keypad scanner has finished the keydetection and valid data is available
 *  ack  = 1 --> waits for this signal. continues to scan the keypad for new keys after key release
 *  -- Sanket
 */

module keypad_scanner #(parameter rows_count=4, 
                        parameter cols_count=4)(input clk, rst, start, [rows_count-1:0] rows, input ack, 
                                                output reg[cols_count-1:0] cols,output reg[cols_count+rows_count-1:0] data, output reg done);

  typedef enum {scan_rows, detect_row, wait_key_release} States_e;

  States_e state,nextState;
  
  always_ff @(posedge clk) begin: rst_clk_blk
    if(!rst) begin
      state <= scan_rows;
    end
    else
      state <= nextState;
  end:rst_clk_blk
  
  always_ff @(posedge clk) begin: Scanning
   if (!rst) begin 
      cols <= '0;
      cols[0] <= 1; 
   end
   else begin
   if(start == 1) begin:start_fsm
    case(state) 
      scan_rows: begin
                     if(rows == 0) begin
                       cols <= {cols[cols_count-2:0],cols[cols_count-1]}; 
                     end
      end
  /*   detect_row: begin 
                    if (ack == 0) data = {rows,cols};
                 end
    */endcase
   end
  end
  end:Scanning
  
  always_comb begin
     case(state) 
      scan_rows: begin 
                   data = '0;
                   done = 0;
                 end

      detect_row: begin 
                    if (ack == 0) begin data = {rows,cols};
                                        done = 1;
                                  end
                    else begin data = 0;
                               done = 0;
                  end
                end            
      wait_key_release: begin 
                   data = 0;
                   done = 0;
                 end  
      default: begin 
                   data = 0;
                   done = 0;
                 end  
    endcase
   
  end

  always_comb begin: state_change

   case(state) 
     scan_rows: begin
                 if(rows != 0 )
                      nextState = detect_row;
                 else
                      nextState = scan_rows;
     end
     detect_row: if(ack == 1) begin
                    nextState = wait_key_release;
                 end
                 else nextState = detect_row;

     wait_key_release: if(rows != 0) nextState = wait_key_release;
                       else          nextState = scan_rows;
   
     default: nextState = scan_rows;
   endcase
  end:state_change

endmodule
