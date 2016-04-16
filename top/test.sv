//********************
// Top level module that creates the UVM test

module test;
import uvm_pkg::*;
import uvmtb_test_pkg::*;

  initial begin
     run_test("test_base");  //start test environment
  end

endmodule
