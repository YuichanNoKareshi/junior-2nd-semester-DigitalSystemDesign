`timescale 1ps/1ps
module pipelined_computer_sim;
	reg resetn_sim, clock_sim, mem_clock_sim,and_model,add_model;
	reg [31:0] in_port0,in_port1;
	wire [31:0] pc_sim, inst_sim, ealu_sim, malu_sim, walu_sim;
	wire [31:0] out_port0,out_port1,out_port2,mem_dataout,io_read_data;
	pipeline_computer_main pipeline_computer_main_instance(resetn_sim, clock_sim, mem_clock_sim, pc_sim, inst_sim, ealu_sim, malu_sim, walu_sim,		
																				out_port0,out_port1,out_port2,in_port0,in_port1,and_model,add_model,mem_dataout,io_read_data);
	initial begin
		clock_sim = 1;
		while (1)
			#2 clock_sim = ~clock_sim;
	end
	initial begin
		mem_clock_sim = 0;
		while (1)
			#2 mem_clock_sim = ~mem_clock_sim;
	end
	initial begin
		resetn_sim = 0;
		while (1)
			#5 resetn_sim = 1;
	end
	initial begin
		in_port0 = 5'b00000;
		while (1) begin
			#20 in_port0 = 5'b11111;
			#20 in_port0 = 5'b00000;
			#20 in_port0 = 5'b11000;
		end
	end
	initial begin
		in_port1 = 5'b00000;
		while (1)begin
			#20 in_port1 = 3'b00000;
			#20 in_port1 = 3'b11000;
			#20 in_port1 = 3'b11111;
		end
	end
	initial begin
		add_model = 1;
		and_model = 1;
		while (1)begin
			#10 and_model = 0;
			#5 and_model = 1;
			#10 add_model = 0;
			#5 add_model = 1;
		end
	end
    initial begin
		$display($time, "resetn=%b clock=%b mem_clock=%b", resetn_sim, clock_sim, mem_clock_sim);
	end
endmodule
