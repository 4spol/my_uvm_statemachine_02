what is new
last week sequence is just to generate 1101 sequence and repeat times is constant; and only can pass the with case0_sequence
this week modify the sequence and add a sequence_library in my_case0 and register two sequence;
one is named case0_sequence0 to generate the rand transaction like 0 or 1, and it also can repeat rand times by using rand int num;
the other is named case0_sequence to generate rand times sequence like 1101;
use seq_lib to generate rand times between case0_sequence and case0_sequence0; and use uvm_config_db#(uvm_sequence_lib_mode)::set(this,"env.i_agt_sqr.main_phase","default_sequence.selection_mode",UVM_SEQ_LIB_RANDC);
config the uvm_sequence_lib_mode to UVM_SEQ_LIB_RANDC

but here comes to some problem, which cased by my_model.sv and statemachine.v
in statemachine.v these state transition is some thing wrong, to debug this use `uvm_info("modelprint",$sformatf("%28b",data_1),UVM_LOW)//use a reg[27:0]data_1 to simulate the dut state to comfirm which sequence input case this problem;
see every time input sequence is 1_1101 always comes problem; the state transitiion is wrong!!!!
check the state transition found when input is 1111->1111 state should be 0011  but it was 0001; it is easy to modify by add condition to exclude 1101_101
in my_model.sv these is promble about the my_model when input is 1101101 which should not be generate 1(because the 1101sequence only check the first 1101 and if input is 1101101 which actual is 1101_101, rather than 110_1101
modify those problem.

now this program updated this version which is fully pass the sequence(which is not by generating rand [27:0]data then data=data+1) to add reg_model