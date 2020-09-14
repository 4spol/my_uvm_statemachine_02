

class my_transactiono extends uvm_sequence_item;//not so different with my_transaction except rand varname and var number

rand bit en;
rand bit [2:0]cnt;
rand bit vaild; 
	
`uvm_object_utils_begin(my_transactiono)
`uvm_field_int(en,UVM_ALL_ON)
`uvm_field_int(cnt,UVM_ALL_ON)
`uvm_field_int(vaild,UVM_ALL_ON | UVM_NOCOMPARE)
`uvm_object_utils_end

function new(string name="my_transactiono");
     super.new();
endfunction
endclass
