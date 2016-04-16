// configuration container class
class uvmtb_display_config extends uvm_object;
 `uvm_object_utils( uvmtb_display_config )
 
/*********************************************************/
 virtual Cal_bfm_if  v_bfm_if;
 /*********************************************************/
 
 function new( string name = "uvmtb_display_config" );
   super.new( name );
 endfunction

endclass