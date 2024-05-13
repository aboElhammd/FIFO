module FIFO_monitor (fifo_interface.monitor interface_1 );
	import FIFO_scoreboard_pack::*;
	import transaction_package::*;
	import coverage_package::*;
	FIFO_transaction fifo_trans;
	FIFO_scoreboard fifo_score=new;
	FIFO_coverage fifo_cover=new;
	logic finish;
	initial begin
		fifo_trans=new();
		forever begin
			finish=0;
			fifo_trans.old_overflow=interface_1.overflow;
			fifo_trans.old_full=interface_1.full;
			fifo_trans.old_empty=interface_1.empty;
			fifo_trans.old_almostfull=interface_1.almostfull;
			fifo_trans.old_almostempty=interface_1.almostempty;
			fifo_trans.old_underflow=interface_1.underflow;
			@(negedge interface_1.clk);
			////////////////////////////inputs 
			fifo_trans.data_in=interface_1.data_in;
			fifo_trans.rst_n=interface_1.rst_n;
			fifo_trans.wr_en=interface_1.wr_en;
			fifo_trans.rd_en=interface_1.rd_en;
			///////////////////////// outputs 
			fifo_trans.data_out=interface_1.data_out;
			fifo_trans.wr_ack=interface_1.wr_ack;
			fifo_trans.overflow=interface_1.overflow;
			fifo_trans.full=interface_1.full;
			fifo_trans.empty=interface_1.empty;
			fifo_trans.almostfull=interface_1.almostfull;
			fifo_trans.almostempty=interface_1.almostempty;
			fifo_trans.underflow=interface_1.underflow;
			
			fork
				begin
					fifo_cover.sample_data(fifo_trans); 	
				end
				begin
					fifo_score.check_data(fifo_trans); 	
				end
			join
			finish=1;
		end
	end
	// always @(posedge finish) begin
	// 	fifo_cover.sample_data(fifo_trans);

	// end
	// always @(posedge finish) begin
	// 	fifo_score.check_data(fifo_trans);
	// //	$display("error = %0d",shared_package::error_count);
	// end
	always@(posedge  shared_package::test_finished)begin
		$stop();
	end
		


endmodule : FIFO_monitor
