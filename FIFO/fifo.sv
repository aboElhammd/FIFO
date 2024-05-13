////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: FIFO Design 
// 
////////////////////////////////////////////////////////////////////////////////
module FIFO(fifo_interface.DUT interface_1);
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;
logic [FIFO_WIDTH-1:0] data_in;
logic clk, rst_n, wr_en, rd_en;
logic [FIFO_WIDTH-1:0] data_out;
logic wr_ack, overflow;
logic full, empty, almostfull, almostempty, underflow;
/*------------------------------------------------------------------------------
--connecting inputs and outputs to interface 
------------------------------------------------------------------------------*/
assign data_in = interface_1.data_in;
assign clk     = interface_1.clk;
assign rst_n   = interface_1.rst_n;
assign wr_en   = interface_1.wr_en;
assign rd_en   = interface_1.rd_en;
                             ////////////////////////////////////
assign interface_1.data_out =   data_out;
assign interface_1.wr_ack =  wr_ack;
assign interface_1.overflow = overflow;
assign interface_1.full = full;
assign interface_1.empty = empty;
assign interface_1.almostfull = almostfull;
assign interface_1.almostempty = almostempty;
assign interface_1.underflow = underflow;
//////////////////////////////////////////////////////////////////////////////
 
localparam max_fifo_addr = $clog2(FIFO_DEPTH);

reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];

reg [max_fifo_addr-1:0] wr_ptr, rd_ptr;
reg [max_fifo_addr:0] count;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		wr_ptr <= 0;
		overflow<=0;
		wr_ack<=0;
	end
	else if (wr_en && count < FIFO_DEPTH) begin
		mem[wr_ptr] <= data_in;
		wr_ack <= 1;
		wr_ptr <= wr_ptr + 1;
		overflow<=0;
	end
	else begin 
		wr_ack <= 0; 
		if (full & wr_en)
			overflow <= 1;
		else
			overflow <= 0;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		rd_ptr <= 0;
		data_out<=0;
		underflow<=0;
	end
	else if (rd_en && count != 0) begin
		data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
		underflow<=0;
	end
	else begin
		if(rd_en &&  count==0)
		underflow<=1;
		else 
		underflow<=0;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		count <= 0;
	end
	else begin
		if	( ({wr_en, rd_en} == 2'b10) && !full) 
			count <= count + 1;
		else if ( ({wr_en, rd_en} == 2'b01) && !empty)
			count <= count - 1;
		else if(({wr_en, rd_en} == 2'b11) && empty)
			count<=count+1;
		else if(({wr_en, rd_en} == 2'b11) && full)
			count<=count-1;
	end
end

assign full = (count == FIFO_DEPTH) ? 1 : 0;
assign empty = (count == 0)? 1 : 0;
// assign underflow = (empty && rd_en && rst_n)? 1 : 0; 
assign almostfull = (count == FIFO_DEPTH-1)? 1 : 0; 
assign almostempty = (count == 1)? 1 : 0;
/*------------------------------------------------------------------------------
--assertions  
------------------------------------------------------------------------------*/
`ifdef ASSERTIONS
	property full_property;
		@(posedge clk) count==FIFO_DEPTH |-> full==1;
	endproperty
	property empty_property;
		@(posedge clk) count==0 |-> empty==1;
	endproperty
	property almost_full_property;
		@(posedge clk) count==FIFO_DEPTH-1 |-> almostfull==1;
	endproperty
	property almost_empty_property;
		@(posedge clk) count==1 |-> almostempty==1;
	endproperty
	///////////////////////////////////////////////////////
	property wr_ack_assertion;
		@(posedge clk) disable iff(!rst_n) (wr_en && !full  ) |-> ##1 wr_ack;
	endproperty
	property overflow_assertion;
		@(posedge clk) disable iff(!rst_n) (wr_en&& full  )   |-> ##1 overflow;
	endproperty
	property underflow_assertion;
		@(posedge clk) disable iff(!rst_n) (rd_en && empty  ) |-> ##1 underflow;
	endproperty
	//////////////////////////////////////////////////////////////
	property wr_ptr_assertion;
		@(posedge clk) disable iff(!rst_n) (wr_en&& !full ) |=> (wr_ptr==$past(wr_ptr)+3'b001);
	endproperty
	property rd_ptr_assertion;
		@(posedge clk) disable iff(!rst_n) (rd_en && !empty ) |=> (rd_ptr==$past(rd_ptr)+3'b001);
	endproperty
	// always_comb begin : proc_ begin
	// 	
	// end
	always_comb begin : proc_
		if(!rst_n) begin
			assert final(empty==1);
			assert final(full==0);
			assert final(almostempty==0);
			assert final (almostfull==0);
			assert final(wr_ack==0);
			assert final(underflow==0);
			assert final(overflow==0);
			assert final(wr_ptr==0);
			assert final(rd_ptr==0);
		end
	end
	label_full_property:assert property(full_property);
	label_empty_property:assert property(empty_property);
	label_almost_empty_property:assert property(almost_empty_property);
	label_almost_full_property:assert property(almost_full_property);
	cover property(full_property);
	cover property(empty_property);
	cover property(almost_empty_property);
	cover property(almost_full_property);
	label_wr_ack:assert property(wr_ack_assertion);
	cover property(wr_ack_assertion);
	label_overflow:assert property(overflow_assertion);
	//assign almostempty=0;
	cover property(overflow_assertion);
	label_underflow:assert property(underflow_assertion);
	cover property(underflow_assertion);
	label_wr_ptr:assert property(wr_ptr_assertion);
	cover property(wr_ptr_assertion);
	label_rd_ptr:assert property(rd_ptr_assertion);
	cover property(rd_ptr_assertion);
`endif 	
endmodule
