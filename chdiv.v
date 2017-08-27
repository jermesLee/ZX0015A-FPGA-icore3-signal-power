module chdiv (clk,rst,c0,c1,c2,cmd0,cmd1,cmd2,vdd);

input wire clk,rst;
input wire [15:0] vdd;
output wire [23:0] cmd0,cmd1,cmd2;
output reg c0,c1,c2;

reg [2:0] cnt;
reg [23:0] ins0,ins1,ins2;
always @ (posedge clk,negedge rst)
	begin
		if (!rst)
			cnt<=3'd0;
		else
			begin
				if (cnt<3'd5)
					cnt<=cnt+1'b1;
				else
					cnt<=3'd0;
			end  
	end  

always @ (posedge clk,negedge rst)
	begin
		if (!rst)
			begin
				c0<=1'b1;c1<=1'b1;c2<=1'b0;ins0<=24'd0;ins1<=24'd0;ins2<=24'd0;
			end
		else
			case (cnt)
				4'd0:begin c0<=1'b1;c1<=1'b0;c2<=1'b1;ins0={4'd3,vdd,4'd0}; end //chanel 0
				
				4'd1:begin c0<=1'b1;c1<=1'b0;c2<=1'b0;ins2={4'd3,16'd0,4'd0}; end //chanel 2
				
				4'd2:begin c0<=1'b1;c1<=1'b1;c2<=1'b0;ins1={4'd3,vdd,4'd0}; end //chanel 1
				
				4'd3:begin c0<=1'b0;c1<=1'b1;c2<=1'b0;ins0={4'd3,16'd0,4'd0}; end //chanel 0
				
				4'd4:begin c0<=1'b0;c1<=1'b1;c2<=1'b1;ins2={4'd3,vdd,4'd0}; end //chanel 2
				
				4'd5:begin c0<=1'b0;c1<=1'b0;c2<=1'b1;ins1={4'd3,16'd0,4'd0}; end //chanel 1
				
				default:begin c0<=1'b1;c1<=1'b1;c2<=1'b0; end
			endcase 
	end  
	
assign cmd0={ins0[0],ins0[1],ins0[2],ins0[3],ins0[4],ins0[5],ins0[6],ins0[7],ins0[8],ins0[9],ins0[10],ins0[11],ins0[12],ins0[13],ins0[14],ins0[15],ins0[16],ins0[17],ins0[18],ins0[19],ins0[20],ins0[21],ins0[22],ins0[23]};
assign cmd1={ins1[0],ins1[1],ins1[2],ins1[3],ins1[4],ins1[5],ins1[6],ins1[7],ins1[8],ins1[9],ins1[10],ins1[11],ins1[12],ins1[13],ins1[14],ins1[15],ins1[16],ins1[17],ins1[18],ins1[19],ins1[20],ins1[21],ins1[22],ins1[23]};
assign cmd2={ins2[0],ins2[1],ins2[2],ins2[3],ins2[4],ins2[5],ins2[6],ins2[7],ins2[8],ins2[9],ins2[10],ins2[11],ins2[12],ins2[13],ins2[14],ins2[15],ins2[16],ins2[17],ins2[18],ins2[19],ins2[20],ins2[21],ins2[22],ins2[23]};
	
endmodule 
