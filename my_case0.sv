class seq_lib extends uvm_sequence_library#(my_transaction);
   function new(string name="seq_lib");
	super.new(name);
	init_sequence_library();//initial seq_lib
set_automatic_phase_objection(1);
   endfunction

   `uvm_object_utils(seq_lib)
   `uvm_sequence_library_utils(seq_lib)//register seq_lib

endclass

class case0_sequence0 extends uvm_sequence #(my_transaction);
	my_transaction m_trans;
	rand int num;//rand num to control generate some rand 0 or 1 sequence
constraint num_cons{
	num>=0;num<=28;
}
	function new(string name="case0_sequence0");
	super.new(name);
	endfunction
`uvm_object_utils(case0_sequence0)
`uvm_add_to_seq_lib(case0_sequence0,seq_lib)
virtual task body();
	`uvm_info("num01",$sformatf("send 0or1 repeat is %0d times",num),UVM_LOW)
	repeat(num)begin
	`uvm_do(m_trans);
	end
endtask
endclass	

class case0_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;
	rand int num;//rand num to control to generate some rand 1101 sequence length
constraint num_cons{
	num>0;
	num<=10;
}
   function  new(string name= "case0_sequence");
      super.new(name);
	
   endfunction 
   
   virtual task body();
	`uvm_info("num1101",$sformatf("send 1101 repeat is %0d times",num),UVM_LOW)
`uvm_do_with(m_trans,{data==1'b1;})
      repeat (num) begin
`uvm_do_with(m_trans,{data==1'b1;})

`uvm_do_with(m_trans,{data==1'b1;})

`uvm_do_with(m_trans,{data==1'b0;})

`uvm_do_with(m_trans,{data==1'b1;})

	`uvm_info("driver2sequence",$sformatf("%0s",m_trans.from_driver),UVM_LOW)//successful driver info 
      end 
   endtask
   `uvm_add_to_seq_lib(case0_sequence,seq_lib)	
   `uvm_object_utils(case0_sequence)
endclass


class my_case0 extends base_test;
   function new(string name = "my_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   `uvm_component_utils(my_case0)
endclass


function void my_case0::build_phase(uvm_phase phase);
   super.build_phase(phase);
	//by default_sequence to configure
   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           seq_lib::type_id::get());//default_sequence 
   uvm_config_db#(uvm_sequence_lib_mode)::set(this,"env.i_agt.sqr.main_phase","default_sequence.selection_mode",UVM_SEQ_LIB_RANDC);
endfunction
     

