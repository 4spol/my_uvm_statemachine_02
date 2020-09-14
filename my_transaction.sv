class my_transaction extends uvm_sequence_item;//uvm_sequence_item hard to say what's this is; maybe just sequence's item

rand bit data;
string from_driver;	
`uvm_object_utils_begin(my_transaction)//register the data to use `uvm_object_utils_begin and _end
`uvm_field_int(data,UVM_ALL_ON)
`uvm_object_utils_end

function new(string name="my_transaction");
     super.new();
endfunction
endclass


