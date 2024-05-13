package coverage_package;
	import  transaction_package::*;
	class FIFO_coverage ;
		 FIFO_transaction F_cvg_txn;
		 ////////////////////////////////////////////
		covergroup cg_1;
			write_label: coverpoint F_cvg_txn.wr_en{
				bins write={1};
				bins donot_write={0};
			}
			read_label : coverpoint F_cvg_txn.rd_en{
				bins read={1};
				bins donot_read={0};
			}
			overflow_label:coverpoint F_cvg_txn.old_overflow{
			bins high={1};
			bins low={0};
			}
			full_label:coverpoint F_cvg_txn.old_full{
			bins high={1};
			bins low={0};
			}
			empty_label :coverpoint F_cvg_txn.old_empty{
			bins high={1};
			bins low={0};
			}
			almostfull_label:coverpoint F_cvg_txn.old_almostfull{
			bins high={1};
			bins low={0};
			}
			almostempty_label:coverpoint F_cvg_txn.old_almostempty{
			bins high={1};
			bins low={0};
			}
			underflow_label:coverpoint F_cvg_txn.old_underflow{
			bins high={1};
			bins low={0};
			}
			cross_write_read_overflow:cross write_label,read_label,overflow_label;
			cross_write_read_full:cross write_label,read_label,full_label;
			cross_write_read_empty:cross write_label,read_label, empty_label; 
			cross_write_read_almostfull:cross write_label,read_label,almostfull_label;
			cross_write_read_almostempty:cross write_label,read_label,almostempty_label;
			cross_write_read_underflow:cross write_label,read_label,underflow_label;
		endgroup : cg_1
		////////////////////////////////
		function new();
			F_cvg_txn=new();
			cg_1=new();
		endfunction : new
		///////////////////////////
		function void sample_data(FIFO_transaction F_txn);
			// F_cvg_txn.copy(F_txn);
			 F_cvg_txn=new F_txn;
			cg_1.sample();
		endfunction : sample_data
		////////////////////////////////
	endclass : FIFO_coverage
endpackage : coverage_package
