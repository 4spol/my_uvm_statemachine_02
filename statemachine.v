module state(i_clk,i_rst_n,i_valid,i_data,o_en,o_cnt,o_valid);
input i_clk,i_rst_n,i_valid,i_data;
output reg o_valid;
output reg o_en;
output  [2:0]o_cnt;
parameter s0= 4'b0000;
parameter s1= 4'b0001;
parameter s2= 4'b0011;
parameter s3= 4'b0110;
parameter s4= 4'b1101;

/*__________________state1__________________________*/
/*__________________flag1___________________________*/
/*__________________o_en____________________________*/
reg [3:0]state1;
reg flag1;//flag1 mean continuous
always@(posedge i_clk)
begin
	if(!i_rst_n) begin state1=s0;flag1=0;o_en=0;end
	else if(i_valid) 
	begin
	case(state1)
	s0: if(i_data) begin  state1=s1;flag1=0;	  o_en=0;end  else if(!i_data) begin  state1=s0;flag1=0;o_en=0;end  //s0= 4'b0000=> s1= 4'b0001; s0= 4'b0000=> s0= 4'b0000
	s1: if(i_data) begin  state1=s2;flag1=flag1;o_en=0;end  else if(!i_data) begin  state1=s0;flag1=0;o_en=0;end  //s1= 4'b0001=> s2= 4'b0011; s1= 4'b0001=> s0= 4'b0000
	s2: if(!i_data)begin  state1=s3;flag1=flag1;o_en=0;end  else if(i_data)  begin  state1=s2;flag1=0;o_en=0;end  //s2= 4'b0011=> s3= 4'b0110; s2= 4'b0011=> s1= 4'b0011; ####### here is an error now it's debugged by using uvm and before correting
//s2: if(!i_data)begin  state1=s3;flag1=flag1;o_en=0;end  else if(i_data)  begin  state1=s1;flag1=0;o_en=0;end
	s3: if(i_data) begin  state1=s4;flag1=flag1;o_en=1;end  else if(!i_data) begin  state1=s0;flag1=0;o_en=0;end  //s3= 4'b0110=> s4= 4'b1101; s3= 4'b0110=> s0= 4'b0000;
	s4: if(i_data) begin  state1=s1;flag1=1;    o_en=0;end  else if(!i_data) begin  state1=s0;flag1=0;o_en=0;end  //s4= 4'b1101=> s1= 4'b0001; s4= 4'b1101=> s0= 4'b0000;
	default:
		 if(i_data) begin state1=s1;flag1=0;	  o_en=0;end  else if(!i_data) begin  state1=s0;flag1=0;o_en=0;end
	endcase
	end
	else  begin state1=state1;flag1=flag1;o_en=o_en;end
end

/*__________________o_cnt__________________________*/

reg [2:0]o_cnt_reg;
always@(posedge i_clk)//modify not much but format and remove the var flag2
begin
	if(i_clk)
	begin
		if(!i_rst_n) begin  o_cnt_reg=0;end
		else if(i_valid) 
		begin
			if(flag1)
			begin
				if(o_en)
					begin 
						if( o_cnt_reg==6) begin  o_cnt_reg= o_cnt_reg;end
						else  o_cnt_reg= o_cnt_reg+1;
					end
				else
					begin 	 o_cnt_reg=o_cnt_reg; end
			end
			else o_cnt_reg=0;
	end
	else begin o_cnt_reg=o_cnt_reg;end
	end
	else begin o_cnt_reg=o_cnt_reg; end
end

assign o_cnt=(flag1)?o_cnt_reg+1:o_en;
/*__________________o_valid__________________________*/
always@(posedge i_clk)
begin
	if(i_clk)
	begin
	if(!i_rst_n) begin o_valid=0;end
	else 
		o_valid=i_valid;
	end
end
endmodule



     

