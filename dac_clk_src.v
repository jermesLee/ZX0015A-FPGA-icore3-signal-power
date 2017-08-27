module dac_clk_src (clk,rst,nck,pck);

input wire clk,rst;
output reg pck,nck;

always @ (posedge clk,negedge rst)
	begin
		if (!rst)
			begin
				pck<=1'b0;nck<=1'b0;
			end  
		else
			begin
				pck<=~pck;
				nck<=pck;
			end  
	end  

endmodule 
