module adc_module (clk,rst,addr,busy,adcdb,conA,conB,conC,adcrst,adccs,adcrd,q);

input wire clk,rst;
input wire [2:0] addr;
input wire busy;
input wire [15:0] adcdb;
output wire conA,conB,conC;
output wire adcrst,adccs,adcrd; 
output wire [15:0] q;

wire [15:0] vadc0,vadc1,vadc2,vadc3,vadc4,vadc5;
adc_driver a1 (.clk0(clk),.rst(rst),.busy(busy),.adcdb(adcdb),.conA(conA),.conB(conB),.conC(conC),.adcrst(adcrst),.adccs(adccs),.adcrd(adcrd),.vadc0(vadc0),.vadc1(vadc1),.vadc2(vadc2),.vadc3(vadc3),.vadc4(vadc4),.vadc5(vadc5));

wire [15:0] vfadc0,vfadc1,vfadc2,vfadc3,vfadc4,vfadc5;
adc_fir a2 (.fir_clk(fir_clk),.rst(rst),.adc_indata(vadc0),.adc_outdata(vfadc0));
adc_fir a3 (.fir_clk(fir_clk),.rst(rst),.adc_indata(vadc1),.adc_outdata(vfadc1));
adc_fir a4 (.fir_clk(fir_clk),.rst(rst),.adc_indata(vadc2),.adc_outdata(vfadc2));
adc_fir a5 (.fir_clk(fir_clk),.rst(rst),.adc_indata(vadc3),.adc_outdata(vfadc3));
adc_fir a6 (.fir_clk(fir_clk),.rst(rst),.adc_indata(vadc4),.adc_outdata(vfadc4));
adc_fir a7 (.fir_clk(fir_clk),.rst(rst),.adc_indata(vadc5),.adc_outdata(vfadc5));

adc_value_csout a8 (.addr(addr),.q0(vfadc0),.q1(vfadc1),.q2(vfadc2),.q3(vfadc3),.q4(vfadc4),.q5(vfadc5),.q(q));

wire fir_clk;
adc_clk_div a9 (.clk(adccs),.rst(rst),.fir_clk(fir_clk));

endmodule 
