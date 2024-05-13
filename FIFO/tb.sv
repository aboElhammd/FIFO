 import FIFO_scoreboard_pack::*;
import transaction_package::*;
import coverage_package::*;

module FIFO_tb (fifo_interface.testbench interface_1);
	FIFO_transaction fifo_1=new;
	initial begin
		interface_1.rst_n=0;
		fifo_1.rst_n=0;
		#5;
		for (int i = 0; i < 10000; i++) begin
			@(negedge interface_1.clk);
			assert(fifo_1.randomize());
			#1;
			interface_1.data_in=fifo_1.data_in;
			interface_1.rst_n=fifo_1.rst_n;
			interface_1.wr_en=fifo_1.wr_en;
			interface_1.rd_en=fifo_1.rd_en;
		end
		$display("correct counts = %0d\nincorrect counts = %0d",shared_package::correct_count , shared_package::error_count);
		shared_package::test_finished=1;
	end
endmodule : FIFO_tb
