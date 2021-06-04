module io_input(
	addr,io_clk,io_read_data,in_port0,in_port1,and_model,add_model
);
	input 	[31:0] 	addr;
	input 			io_clk,and_model,add_model;
	input 	[31:0] 	in_port0,in_port1;
	output 	[31:0] 	io_read_data;
	
	reg 	[31:0] 	in_reg0;
	reg 	[31:0] 	in_reg1;
	
	io_input_mux io_imput_mux2x32(in_reg0,in_reg1,addr[7:2],io_read_data,and_model,add_model);
	
	always @(posedge io_clk)
	begin
		in_reg0 <= in_port0;
		in_reg1 <= in_port1;
	end
endmodule

module io_input_mux(a0,a1,sel_addr,y,and_model,add_model);
	input 	[31:0]	a0,a1;
	input 	[ 5:0]	sel_addr;
	input             and_model,add_model;
	output 	[31:0]	y;
	reg 	[31:0] 	y;
	always @ *
		begin
		case (sel_addr)
			6'b100000: y = a0; // 128
			6'b100001: y = a1; // 132
			6'b100011: y = and_model; // 140
			6'b100100: y = add_model; // 144
		endcase
		end
endmodule