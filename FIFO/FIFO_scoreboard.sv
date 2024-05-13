package FIFO_scoreboard_pack;
	import shared_package::*;
	import transaction_package::*;
	// int address=clog2(FIFO_DEPTH);
	class FIFO_scoreboard ;
		logic [FIFO_WIDTH-1:0] queue[$];
		//int correct_count,error_count;
		logic [FIFO_WIDTH-1:0] data_out_ref;
		logic wr_ack_ref, overflow_ref;
		logic full_ref, empty_ref, almostfull_ref, almostempty_ref, underflow_ref;
		function check_data(FIFO_transaction checked_object);
			reference_model(checked_object);
			if(data_out_ref!=checked_object.data_out)begin
				$display("error in data_out at time %0t",$time());
				error_count++;
			end
			else 
				correct_count++;
			if(wr_ack_ref!=checked_object.wr_ack)begin
				$display("error in wr_ack at time %0t",$time());
				error_count++;
			end
			else 
				correct_count++;
			if(overflow_ref!=checked_object.overflow)begin
				$display("error in overflow at time %0t",$time());
				error_count++;
			end
			else 
				correct_count++;
			if(full_ref!=checked_object.full)begin
				$display("error in full at time %0t",$time());
				error_count++;
			end
			else 
				correct_count++;
			if(empty_ref!=checked_object.empty)begin
				$display("error in empty at time %0t",$time());
				error_count++;
			end
			else 
				correct_count++;
			if(almostfull_ref!=checked_object.almostfull)begin
				$display("error in almostfull at time %0t",$time());
				error_count++;
			end
			else 
				correct_count++;
			if(almostempty_ref!=checked_object.almostempty)begin
				$display("error in almostempty at time %0t",$time());
				error_count++;
			end
			else 
				correct_count++;
			if(underflow_ref!=checked_object.underflow)begin
				$display("error in underflow at time %0t",$time());
				error_count++;
			end
			else 
				correct_count++;
		endfunction : check_data
		function void reference_model(FIFO_transaction checked_object);
			// static [address-1:0]rd_ptr,wr_ptr;
			if(!checked_object.rst_n)begin
				queue.delete();
				underflow_ref=0;
				overflow_ref=0;
				wr_ack_ref=0;
				data_out_ref=0;
			end
			else begin
				overflow_ref=(full_ref && checked_object.wr_en ) ? 1:0;
				underflow_ref=(empty_ref && checked_object.rd_en ) ? 1:0 ;
				fork
					begin
						if(checked_object.wr_en && !full_ref)begin
							queue.push_back(checked_object.data_in);
							wr_ack_ref=1;
						end
						else 
							wr_ack_ref=0;
					end
					begin
						if(checked_object.rd_en && !empty_ref)
							data_out_ref=queue.pop_front();
					end

				join
			end
			full_ref=(queue.size()==FIFO_DEPTH) ? 1 : 0;
			empty_ref=(queue.size()==0) ? 1 : 0;
			almostfull_ref=(queue.size()==FIFO_DEPTH-1) ? 1 : 0;
			almostempty_ref=(queue.size()==1) ? 1 : 0;
		endfunction  : reference_model
	endclass : FIFO_scoreboard
endpackage : FIFO_scoreboard_pack
