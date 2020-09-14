class my_monitor extends uvm_monitor;
`uvm_component_utils(my_monitor);

function new(string name="my_monitor",uvm_component parent);
super.new(name,parent);
endfunction

uvm_analysis_port #(my_transaction) ap;
virtual my_if vif;//monitor for input must has the input interface

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_monitor", "virtual interface must be set for vif!!!")
      ap = new("ap", this);
   endfunction

task main_phase(uvm_phase phase);
   my_transaction tr;
   while(1) begin
      tr = new("tr");
      collect_one(tr);//method for monitoring dut behavior
//transfer dut behavior to transaction
      ap.write(tr);//send dut behavior to model through analysis port to env's fifo 
   end
endtask

task collect_one(my_transaction tr);
  	 logic data;
  	 logic vaild = 0;

while(1) begin
	@(posedge vif.clk);
	if(vif.vaild) break;//vaild to control 
end
/*
   while(vif.vaild) begin
        tr.data = data; 
      @(posedge vif.clk);
   end*/


	while(vif.vaild)begin
		tr.data=vif.data;
		@(posedge vif.clk);
	end
`uvm_info("monitor","run",UVM_MEDIUM)
    
endtask
endclass


     

