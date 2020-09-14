class my_driver extends uvm_driver#(my_transaction);


   virtual my_if vif;//interface for input instance

   `uvm_component_utils(my_driver)
   function new(string name = "my_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_driver", "virtual interface must be set for vif!!!")
   endfunction

task main_phase(uvm_phase phase);
	vif.vaild<=1'b0;
	vif.data<=1'b0;
	
	while(!vif.rst_n)
	@(posedge vif.clk);
	
while(1) begin
seq_item_port.get_next_item(req);
drive_one(req);
req.from_driver="driver seccuss";
seq_item_port.item_done();
end
endtask

task drive_one(my_transaction tr);
byte unsigned data_q[];



repeat(1)@(posedge vif.clk);

	@(posedge vif.clk);
	vif.vaild<=1'b1;//control signal
	vif.data<=tr.data;


@(posedge vif.clk);
	vif.vaild<=1'b0;
@(posedge vif.clk);
endtask
endclass

