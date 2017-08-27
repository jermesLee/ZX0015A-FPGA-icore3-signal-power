module mod_dac (clk,rst,cmd,sync,scl,sdo,ldac,drst);

input wire clk,rst;
input wire [23:0] cmd;
output wire sync,scl,sdo,ldac,drst;

wire pck,nck;
dac_clk_src m0 (.clk(clk),.rst(rst),.nck(nck),.pck(pck));
dac_seq_crt m1 (.clk(clk),.rst(rst),.cmd(cmd),.pck(pck),.nck(nck),.sync(sync),.scl(scl),.sdo(sdo),.ldac(ldac),.drst(drst));

endmodule 
