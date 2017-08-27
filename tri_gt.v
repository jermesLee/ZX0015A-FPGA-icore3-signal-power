module tri_gt (OE,id,od);

input wire OE;
input wire [15:0] id;
output wire [15:0] od;

assign od=(!OE)?16'dz:id;
endmodule
		
