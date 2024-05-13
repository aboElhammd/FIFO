module top ();
	logic clk;
	initial begin
		clk=1;
		forever begin
		#2	clk=~clk;
		end
	end
	fifo_interface interface_1(clk);
	FIFO DUT(interface_1);
	FIFO_tb testbench(interface_1);
	FIFO_monitor monitor_interface(interface_1);
endmodule : top


