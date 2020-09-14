class my_monitoro extends uvm_monitor;//monitor for  dut output 
`uvm_component_utils(my_monitoro);

function new(string name="my_monitoro",uvm_component parent);
super.new(name,parent);
endfunction

uvm_analysis_port #(my_transactiono) ap;
virtual my_ifo vif;

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(virtual my_ifo)::get(this,"","vif",vif))//must use uvm_config_db#(virtual my_if)::set(null(or use uvm_root::get()),"ab path to monitoro","vif",vif instance) in tob_tb
	`uvm_fatal("my_monitoro","virtual interface must be set for vif!!!")
ap=new("ap",this);
endfunction

task main_phase(uvm_phase phase);
my_transactiono tr;
while(1) begin
tr=new("tr");
collect_one(tr);
ap.write(tr);
end
endtask

task collect_one(my_transactiono tr);
logic vaild=0;
logic en;
logic [2:0]cnt;


while(1)begin
	@(posedge vif.clk);
	if(vif.vaild) break;
end

   while(vif.vaild) begin
	tr.en=vif.en;
	tr.cnt=vif.cnt;
	tr.vaild=vif.vaild;
      @(posedge vif.clk);
   end
   `uvm_info("my_monitoro", "end collect one pkt", UVM_LOW);
endtask
endclass


     

