module main_stopwatch(
	CLOCK_50, key_reset, key_start_pause, key_display_stop,
	hex0, hex1, hex2, hex3, hex4, hex5,
	led0, led1, led2, led3
);

	input CLOCK_50, key_reset, key_start_pause, key_display_stop;
	output [6:0] hex0, hex1, hex2, hex3, hex4, hex5;
	output led0, led1, led2, led3;
	
	reg [3:0] minute_display_high;
	reg [3:0] minute_display_low;
	reg [3:0] second_display_high;
	reg [3:0] second_display_low;
	reg [3:0] msecond_display_high;
	reg [3:0] msecond_display_low;
	
	reg [3:0] minute_counter_high;
	reg [3:0] minute_counter_low;
	reg [3:0] second_counter_high;
	reg [3:0] second_counter_low;
	reg [3:0] msecond_counter_high;
	reg [3:0] msecond_counter_low;
	
	reg counter_stop, display_stop, will_reset;
	wire counter, display;
	
	//10ms
	reg [31:0] counter_100HZ;
	
	//50ms
	reg [31:0] counter_40HZ;
	
	reg CLOCK_100HZ;
	
	reg [31:0] counter_reset;
	reg [31:0] counter_start;
	reg [31:0] counter_display;
	
	sevenseg LED8_minute_display_high(minute_display_high, hex5);
	sevenseg LED8_minute_display_low(minute_display_low, hex4);
	
	sevenseg LED8_second_display_high(second_display_high, hex3);
	sevenseg LED8_second_display_low(second_display_low, hex2);
	
	sevenseg LED8_msecond_display_high(msecond_display_high, hex1);
	sevenseg LED8_msecond_display_low(msecond_display_low, hex0);	

	debounce debounce_counter(.CLOCK(CLOCK_40HZ), .RESET(key_reset), .key_in(key_start_pause), .key_out(counter));
	debounce debounce_display(.CLOCK(CLOCK_40HZ), .RESET(key_reset), .key_in(key_display_stop), .key_out(display));

	//produce 10ms(100HZ) clock
	always @ (posedge CLOCK_50)
		begin 
			if (counter_100HZ == 249999)
				begin
					counter_100HZ <= 0; // set to 0
					CLOCK_100HZ <= ~CLOCK_100HZ;
				end
			else
				begin
					counter_100HZ <= counter_100HZ + 1;
				end
		end
		
	always @ (posedge key_start_pause)
		begin
			if (!counter)
				begin
					counter_stop <= ~counter_stop;
				end
		end
	
	always @ (posedge key_display_stop)
		begin
			if (!display)
				begin
					display_stop <= ~display_stop;
				end
		end
	
	always @ (posedge CLOCK_100HZ)
		begin
			//重置
			if (~key_reset)
				begin
					msecond_counter_low <= 0;
					msecond_counter_high <= 0;
					second_counter_low <= 0;
					second_counter_high <= 0;
					minute_counter_low <= 0;
					minute_counter_high <= 0;
					msecond_display_low <=0;
					msecond_display_high <= 0;
					second_display_low <= 0;
					second_display_high <= 0;
					minute_display_low <= 0;
					minute_display_high <= 0;
				end
				
			//开始进位
			if (~counter_stop )
				begin
					if (msecond_counter_low == 9)
						begin
							msecond_counter_low <= 0;
							msecond_counter_high <= msecond_counter_high + 1;
						end
					else
						begin
							msecond_counter_low <= msecond_counter_low + 1;
						end
					
					if (msecond_counter_high == 10)
						begin
							msecond_counter_high <= 0;
							second_counter_low <= second_counter_low + 1;
						end
						
					if (second_counter_low == 10)
						begin 
							second_counter_low <= 0;
							second_counter_high <= second_counter_high + 1;
						end
						
					if (second_counter_high == 6)
						begin
							second_counter_high <= 0;
							minute_counter_low <= minute_counter_low + 1;
						end
						
					if (minute_counter_low == 10)
						begin
							minute_counter_low <= 0;
							minute_counter_high <= minute_counter_high + 1;
						end
				end
				
			//如果没有停止展示，就更换
			if (~display_stop)
				begin
					msecond_display_low <= msecond_counter_low;
					msecond_display_high <= msecond_counter_high;
					second_display_low <= second_counter_low;
					second_display_high <= second_counter_high;
					minute_display_low <= minute_counter_low;
					minute_display_high <= minute_counter_high;
				end
		end
endmodule
	
	
	
	