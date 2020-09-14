`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_if.sv"
`include "my_ifo.sv"
`include "my_transaction.sv"
`include "my_transactiono.sv"
`include "my_sequencer.sv"
`include "my_driver.sv"
`include "my_monitor.sv"
`include "my_monitoro.sv"
`include "my_agent.sv"
`include "my_agento.sv"
`include "my_model.sv"
`include "my_scoreboard.sv"
`include "my_env.sv"
`include "base_test.sv"
`include "my_case0.sv"

//`include "document name"
module top_tb;

reg clk;
reg rst_n;
reg valid;
reg data;

wire en;
wire [2:0]cnt;
wire vaild;
my_if input_if(clk, rst_n);//instance of interface
my_ifo output_if(clk, rst_n);
// instance of state.v design under test
state my_dut(.i_clk(clk),
	.i_rst_n(rst_n),
	.i_valid(input_if.vaild),
	.i_data(input_if.data),
	.o_en(output_if.en),
	.o_cnt(output_if.cnt),
	.o_valid(output_if.vaild)
);

initial begin//generate clk 200 clk_cycle
   clk = 0;
   forever begin
      #100 clk = ~clk;
   end
end

initial begin//generate rst_n signal
   rst_n = 1'b0;
   #1000;
   rst_n = 1'b1;
end

initial begin
   run_test("my_case0");//can be use command in terminal
end

initial begin
//set vif 
//null means uvm_root::get()
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.drv", "vif", input_if);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.mon", "vif", input_if);
   uvm_config_db#(virtual my_ifo)::set(null, "uvm_test_top.env.o_agt.mon", "vif", output_if);
end

endmodule
