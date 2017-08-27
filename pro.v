module pro (
				clk,rst,//system
				wr,rd,DB,A,//fsmc
				ch0,ch1,ch2,//dac
				drst0,ldac0,scl0,sdo0,sync0,//dac chanel 0
				drst1,ldac1,scl1,sdo1,sync1,//dac chanel 1
				drst2,ldac2,scl2,sdo2,sync2,//dac chanel 2
				busy,adcdb,conA,conB,conC,adcrst,adccs,adcrd//adc
				);
//system				
input wire clk,rst;
//fsmc
input wire wr,rd;
inout wire [15:0] DB;
//dac
input wire [2:0] A;
output wire ch0,ch1,ch2;
output wire drst0,ldac0,scl0,sdo0,sync0;
output wire drst1,ldac1,scl1,sdo1,sync1;
output wire drst2,ldac2,scl2,sdo2,sync2;
//adc
input wire busy;
input wire [15:0] adcdb;
output wire conA,conB,conC;
output wire adcrst,adccs,adcrd;

wire c0,c1,c2,c3;//c0 50M,c1 90M,c2 100M,c3 10M
pll p0 (.inclk0(clk),.c0(c0),.c1(c1),.c2(c2),.c3(c3));
wire [22:0] dcnt;
wire cd;
clkdiv p1 (.clk(c1),.rst(rst),.dcnt(dcnt),.cd(cd));
wire [31:0] cmd0,cmd1,cmd2;
wire [15:0] vdd;
chdiv p2 (.clk(cd),.rst(rst),.c0(ch0),.c1(ch1),.c2(ch2),.cmd0(cmd0),.cmd1(cmd1),.cmd2(cmd2),.vdd(vdd));
mod_dac p3 (.clk(c0),.rst(rst),.cmd(cmd0),.sync(sync0),.scl(scl0),.sdo(sdo0),.ldac(ldac0),.drst(drst0));
mod_dac p4 (.clk(c0),.rst(rst),.cmd(cmd1),.sync(sync1),.scl(scl1),.sdo(sdo1),.ldac(ldac1),.drst(drst1));
mod_dac p5 (.clk(c0),.rst(rst),.cmd(cmd2),.sync(sync2),.scl(scl2),.sdo(sdo2),.ldac(ldac2),.drst(drst2));
trsfrm p6 (.rst(rst),.wr(wr),.rd(rd),.DB(DB),.A(A[1:0]),.dcnt(dcnt),.vdd(vdd),.indata(q));
wire [15:0] q;
adc_module p7 (.clk(c3),.rst(rst),.addr(A),.busy(busy),.adcdb(adcdb),.conA(conA),.conB(conB),.conC(conC),.adcrst(adcrst),.adccs(adccs),.adcrd(adcrd),.q(q));

endmodule 
				