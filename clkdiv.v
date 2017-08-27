module clkdiv (clk,rst,dcnt,cd);

input wire clk,rst;
input wire [22:0] dcnt;
output reg cd;

reg [22:0] cnt;
always @ (posedge clk,negedge rst)
	begin
		if (!rst)
			begin
				cnt<=23'd0;
			end  
		else
			if (cnt<dcnt)
				begin
					cnt<=cnt+1'b1;cd<=cd;
				end  
			else
				begin
					cnt<=23'd0;cd<=~cd;
				end  
	end  
	
endmodule 
