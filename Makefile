default:
	@echo "-------------------------------------------------------------------------------------------------"
	@echo "Use following option:"
	@echo "1. make compile : Create working folder and to compile dut and test files"
	@echo "2. make optimize: optimize the design without debugging facillities"
	@echo "3. make sim     : Run Simulation with top module"
	@echo "4. make debug   : Compile, optimize and run simulation with debugging facilities"
	@echo "5. make cmd     : compile, optimize and runs the simulation in current command window(no GUI)"
	@echo "6. make cover   : run coverstore example along with vcover parallelmerge and also generates HTML report"
	@echo "7. make clean   : cleans the working folder and other temerory files"
	@echo "-------------------------------------------------------------------------------------------------"

CMD_VERBOSITY = +UVM_VERBOSITY=UVM_MEDIUM
DEBUG_VERBOSITY = +UVM_VERBOSITY=UVM_DEBUG
COVERAGE_VERBOSITY = +UVM_VERBOSITY=UVM_NONE
TESTCASE = +UVM_TESTNAME=cal_test
DEBUG_SWITCHES = -debugDB -classdebug -uvmcontrol=all -msgmode both +UVM_NO_RELNOTES

compile:
	vlib work 
	vmap work work
	vlog -f compile_dut_files.f 
	vlog -f compile_test_files.f 

optimize: compile
	vopt top test -o top_opt -designfile design.bin

sim: 
	vsim -visualizer top_opt -do "do run.do;" $(TESTCASE) $(CMD_VERBOSITY) +UVM_NO_RELNOTES

cmd:  compile optimize sim

optimizedb:
	vopt +acc top test -debugdb -o top_opt -designfile design.db

simdb:
	vsim top_opt -do run.do $(DEBUG_SWITCHES) $(TESTCASE) $(DEBUG_VERBOSITY) 
	

debug: compile optimizedb simdb

compile_cover: 
	vlib work 
	vmap work work
	vlog -f compile_dut_files.f +cover=bcesft
	vlog -f compile_test_files.f

cover: compile_cover sim_cover cover_merge coverage_report

optimize_cover: 
	vopt +acc top -o top_opt +cover=bcestf+/top/cal. -nofsmresettrans

sim_cover: 
	vsim -c -voptargs="+acc -nofsmresettrans" -sv_seed random \
		top test -do cover_run.do -coverage -toggleportsonly \
		-coverstore calculator_coverstore -testname random_test \
		+UVM_NO_RELNOTES +UVM_TESTNAME=cal_random_test $(COVERAGE_VERBOSITY) -cvg63
	vsim -c -voptargs="+acc -nofsmresettrans" -sv_seed random \
		top test -do cover_run.do -coverage -toggleportsonly \
		-coverstore calculator_coverstore -testname single_digit_test \
		+UVM_NO_RELNOTES +UVM_TESTNAME=cal_single_digit_operation_test $(COVERAGE_VERBOSITY) -cvg63
	vsim -c -voptargs="+acc -nofsmresettrans" -sv_seed random \
		top test -do cover_run.do -coverage -toggleportsonly \
		-coverstore calculator_coverstore -testname operand_two_zero_test \
		+UVM_NO_RELNOTES +UVM_TESTNAME=cal_2ndOperand_equal_0_test $(COVERAGE_VERBOSITY) -cvg63

cover_merge:
	vcover parallelmerge -covmode covstore -genlistfrom ./calculator_coverstore -outname cov_merge_dir

coverage_report:
	vcover report -html ./cov_merge_dir -source -details

clean:
	rm -rf  *.tmp  *.log  log transcript work *.wlf vsim.fcdb *stacktrace* *.dbg *.db merge TEMP* *.rpt calculator_coverstore parallellist cov_merge_dir
	if [ -a covhtmlreport ] ; then \
     rm -r covhtmlreport ; fi;
	if [ -a *.rpt ] ; then \
     rm -r *.rpt ; fi;
