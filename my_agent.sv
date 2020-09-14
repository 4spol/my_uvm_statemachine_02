`ifndef MY_AGENT__SV
`define MY_AGENT__SV

class my_agent extends uvm_agent ;
   my_sequencer  sqr;
   my_driver     drv;
   my_monitor    mon;
   // is_active is not necessary here because agent is seperate into two parts,one is input the other is output;
   uvm_analysis_port #(my_transaction)  ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(my_agent)
endclass 


function void my_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);//build_phase to create instances
//which is build_phase operate from top to bottom
      sqr = my_sequencer::type_id::create("sqr", this);
      drv = my_driver::type_id::create("drv", this);
   mon = my_monitor::type_id::create("mon", this);
endfunction 

function void my_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //connect_phase to connect port; like this drv.seq_item_port.connect(sqr.seq_item_export)
      drv.seq_item_port.connect(sqr.seq_item_export);

   ap = mon.ap;
endfunction

`endif

