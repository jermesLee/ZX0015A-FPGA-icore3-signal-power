module adc_driver (clk0,rst,busy,adcdb,conA,conB,conC,adcrst,adccs,adcrd,vadc0,vadc1,vadc2,vadc3,vadc4,vadc5);

input wire clk0,rst;
input wire busy;
input wire [15:0] adcdb;
output wire conA,conB,conC;
output reg adcrst,adccs,adcrd;
output wire [15:0] vadc0,vadc1,vadc2,vadc3,vadc4,vadc5;

wire c0;
assign c0=clk0;

reg [4:0] st;
parameter [4:0] 
	s0=5'd0,s1=5'd1,s2=5'd2,s3=5'd3,s4=5'd4,s5=5'd5,s6=5'd6,s7=5'd7,s8=5'd8,s9=5'd9,s10=5'd10,s11=5'd11,s12=5'd12,s13=5'd13,s14=5'd14,s15=5'd15,s16=5'd16,s17=5'd17;
	
always @ (posedge c0,negedge rst)
	begin
		if (!rst)
			begin
				st<=s0;
			end  
		else
			case (st)
				s0:begin st<=s1; end 
				s1:begin if (delay<7'd5) st<=s1; else st<=s2; end 
				s2:begin st<=s3; end 
				s3:begin st<=s4; end 
				s4:begin st<=s5; end 
				s5:begin if (delay<7'd114) st<=s5;else st<=s6; end 
				s6:begin st<=s7;  end
				s7:begin st<=s8; end 
				s8:begin st<=s9; end 
				s9:begin st<=s10; end 
				s10:begin st<=s11; end 
				s11:begin st<=s12; end 
				s12:begin st<=s13; end 
				s13:begin st<=s14; end 
				s14:begin st<=s15; end 
				s15:begin st<=s16; end 
				s16:begin st<=s17; end 
				s17:begin st<=s3; end  
			endcase 
	end  

reg delay_en;
reg [2:0] con,radd;
always @ (posedge c0,negedge rst)
	begin
		if (!rst)
			begin
				con<=3'd0;adcrst<=1'b1;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b1;radd<=3'd5;
			end  
		else
			case (st)
				s0:begin con<=3'd7;adcrst<=1'b1;delay_en<=1'b0;adccs<=1'b1;adcrd<=1'b1;radd<=3'd5; end 
				s1:begin con<=3'd7;adcrst<=1'b1;delay_en<=1'b1;adccs<=1'b1;adcrd<=1'b1;radd<=3'd5; end //generate adcrst signal
				s2:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b1;adcrd<=1'b1;radd<=3'd5; end //reset delay counter
				s3:begin con<=3'd0;adcrst<=1'b0;delay_en<=1'b1;adccs<=1'b1;adcrd<=1'b1;radd<=3'd5; end 
				s4:begin con<=3'd0;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b1;adcrd<=1'b1;radd<=3'd5; end //generate valid convest falling edge and then rising edge 
				s5:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b1;adccs<=1'b1;adcrd<=1'b1;radd<=3'd5; end 	
				s6:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b0;radd<=3'd0; end 
				s7:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b1;radd<=3'd0; end //read chanel 0
				s8:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b0;radd<=3'd1; end 
				s9:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b1;radd<=3'd1; end //read chanel 1
				s10:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b0;radd<=3'd2; end 
				s11:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b1;radd<=3'd2; end //read chanel 2
				s12:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b0;radd<=3'd3; end 
				s13:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b1;radd<=3'd3; end //read chanel 3
				s14:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b0;radd<=3'd4; end 
				s15:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b1;radd<=3'd4; end //read chanel 4
				s16:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b0;radd<=3'd5; end 
				s17:begin con<=3'd7;adcrst<=1'b0;delay_en<=1'b0;adccs<=1'b0;adcrd<=1'b1;radd<=3'd5; end //read chanel 5
			endcase 
	end 

reg [6:0] delay;
always @ (posedge c0,negedge rst)
	begin 
		if (!rst)
			begin
				delay<=7'd0;
			end  
		else
			begin
				if (delay_en)
					delay<=delay+1'b1;
				else
					delay<=7'd0;
			end 
	end   
	
reg [15:0] v_adc_strg [5:0];	
always @ (posedge c0,posedge adcrd)
	begin
		if (adcrd)
			v_adc_strg[radd]<=adcdb;
	end 

assign conA=con[0];
assign conB=con[1];
assign conC=con[2];	
	
assign vadc0=v_adc_strg[0];
assign vadc1=v_adc_strg[1];
assign vadc2=v_adc_strg[2];
assign vadc3=v_adc_strg[3];
assign vadc4=v_adc_strg[4];
assign vadc5=v_adc_strg[5];
	
endmodule 
