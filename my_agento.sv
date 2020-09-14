class my_agento extends uvm_agent ;

   my_monitoro    mon;
   //only for output agent
   uvm_analysis_port #(my_transactiono)  ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(my_agento)
endclass 


function void my_agento::build_phase(uvm_phase phase);
   super.build_phase(phase);
   mon = my_monitoro::type_id::create("mon", this);
endfunction 

function void my_agento::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   ap = mon.ap;//connect monitoro.analsys_port
endfunction
