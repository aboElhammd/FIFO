package transaction_package;
	parameter FIFO_WIDTH = 16;
	parameter FIFO_DEPTH = 8;
	class FIFO_transaction ;
		//fifo inputs and outputs
		rand bit [FIFO_WIDTH-1:0] data_in;
		rand bit clk, rst_n, wr_en, rd_en;
		rand bit [FIFO_WIDTH-1:0] data_out;
		rand bit wr_ack, overflow;
		rand bit full, empty, almostfull, almostempty, underflow;
		bit  old_full, old_empty, old_almostfull, old_almostempty, old_underflow,old_overflow; 
		//integres used for constrains
		int WR_EN_ON_DIST=70;
		int RD_EN_ON_DIST=30;
		constraint c_1 {
			rst_n dist {1:=95,0:=5};
			wr_en dist {1:=WR_EN_ON_DIST,0:=100-WR_EN_ON_DIST};
			rd_en dist {1:=RD_EN_ON_DIST,0:=100-RD_EN_ON_DIST};
		}

	endclass : FIFO_transaction
endpackage : transaction_package
