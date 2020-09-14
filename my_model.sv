class my_model extends uvm_component;
 	uvm_analysis_port #(my_transactiono) ap;//port instance
 	uvm_blocking_get_port #(my_transaction) port;
	`uvm_component_utils(my_model)
function new(string name,uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
ap=new("ap",this);
port=new("port",this);
endfunction

task main_phase(uvm_phase phase);
my_transaction tr;
my_transactiono tro;
super.main_phase(phase);
while(1)begin
port.get(tr);
get_monitor(tr,tro);//to transfer my_transaction to my_transactiono
      ap.write(tro);
end
endtask
logic [27:0]data_1;logic[2:0]cnt;//local var for model
task get_monitor(my_transaction tr,output my_transactiono tro);
  	
	tro=new("tro");
	
	data_1={data_1[26:0],tr.data};
`uvm_info("modelprint",$sformatf("-----------%28b-------------",data_1),UVM_LOW)//use a reg[27:0]data_1 to simulate the dut state
/*_____en___vaild____*/
if(data_1[3:0]==4'b1101&&data_1[6:3]!=4'b1101)begin tro.vaild=1;tro.en=1; end
else begin tro.en=0;tro.vaild=1; end
/*__________cnt______*/
if(data_1[27:0]=={7{4'b1101}}) begin cnt=7;  end//if data_1[27:0]==28'b1101_1101_1101_1101_1101_1101_1101
else if(data_1[23:0]=={6{4'b1101}}) begin cnt=6;  end//data_1[24:0]==24'b1101_1101_1101_1101_1101_1101
else if(data_1[19:0]=={5{4'b1101}}) begin cnt=5;  end//data_1[20:0]==24'b1101_1101_1101_1101_1101
else if(data_1[15:0]=={4{4'b1101}}) begin cnt=4;  end//
else if(data_1[11:0]=={3{4'b1101}}) begin cnt=3;  end
else if(data_1[7:0]=={2{4'b1101}}) begin cnt=2;  end
else if(data_1[6:0]==7'b1101110) begin cnt=cnt;  end//cnt must stay same state before its uncontinuous sequence for not to input 110
else if(data_1[5:0]==6'b110111) begin cnt=cnt;  end//cnt must stay same state before its uncontinuous sequence for not to input 11
else if(data_1[4:0]==5'b11011) begin cnt=cnt;  end//cnt must stay same state before its uncontinuous sequence for not to input 11
else if(data_1[3:0]==4'b1101&&data_1[6:3]!=4'b1101) begin cnt=1;  end
else cnt=0;//else cnt=0;is must need
tro.cnt=cnt;
endtask

endclass
