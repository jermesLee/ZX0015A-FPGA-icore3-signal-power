module adc_clk_div (clk,rst,fir_clk);

input wire clk,rst;
output wire fir_clk;

reg [4:0] cnt;
always @ (posedge clk,negedge rst)
	begin
		if (!rst)
			cnt<=5'd0;
		else
			cnt<=cnt+1'b1;
	end  

assign fir_clk=cnt[4];
	
endmodule 
