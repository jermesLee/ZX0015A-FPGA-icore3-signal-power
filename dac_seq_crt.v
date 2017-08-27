module dac_seq_crt (clk,rst,cmd,pck,nck,sync,scl,sdo,ldac,drst);

input wire clk,rst,pck,nck;
input wire [23:0] cmd;
output reg sync,scl,sdo,ldac,drst;

reg [1:0] st;
parameter [1:0] 
	s0=2'd0,s1=2'd1,s2=2'd2;
	
always @ (posedge clk,negedge rst)
	begin
		if (!rst)
			begin
				st<=s0;
			end  
		else
			begin
				case (st)
					s0:begin st<=s1; end  
					s1:begin st<=s2; end  
					s2:begin if (cnt<5'd24) st<=s2; else st<=s0; end  
				endcase
			end  
	end  
	
reg cnt_en;
always @ (posedge clk,negedge rst)
	begin
		if (!rst)
			begin
				sync<=1'b1;scl<=1'b0;sdo<=1'b0;ldac<=1'b0;drst<=1'b0;cnt_en<=1'b0;
			end  
		else
			begin
				case (st)
					s0:begin sync<=1'b1;scl<=1'b1;sdo<=1'b0;ldac<=1'b0;drst<=1'b1; cnt_en<=1'b0; end  
					s1:begin sync<=1'b1;scl<=1'b1;sdo<=1'b0;ldac<=1'b1;drst<=1'b1; cnt_en<=1'b0; end  
					s2:begin sync<=1'b0;scl<=pck;sdo<=dreg;ldac<=1'b1;drst<=1'b1; cnt_en<=1'b1; end  
				endcase
			end  
	end 
	
reg [4:0] cnt;
always @ (posedge nck,negedge rst)
	begin
		if (!rst)
			begin
				cnt<=5'd0;
			end  
		else
			begin
				if (cnt_en)
					cnt<=cnt+1'b1;
				else
					cnt<=5'd0;
			end  
	end  
	
reg dreg;
always @ (posedge pck,negedge rst)
	begin
		if (!rst)
			begin
				dreg<=1'b0;
			end  
		else
			dreg<=cmd[cnt];
	end  
	
endmodule 
