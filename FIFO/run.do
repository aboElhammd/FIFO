vlib work
vlog transaction_package.sv coverage_package.sv FIFO_scoreboard.sv fifo.sv interface.sv tb.sv top.sv monitor.sv +define+ASSERTIONS  +cover
vsim -voptargs=+acc work.top -cover
add wave -position insertpoint  \
sim:/top/DUT/FIFO_WIDTH \
sim:/top/DUT/FIFO_DEPTH \
sim:/top/DUT/max_fifo_addr \
sim:/top/DUT/data_in \
sim:/top/DUT/clk \
sim:/top/DUT/rst_n \
sim:/top/DUT/wr_en \
sim:/top/DUT/rd_en \
sim:/top/DUT/data_out \
sim:/top/monitor_interface/fifo_score.data_out_ref \
sim:/top/DUT/wr_ack \
sim:/top/monitor_interface/fifo_score.wr_ack_ref \
sim:/top/DUT/overflow \
sim:/top/monitor_interface/fifo_score.overflow_ref \
sim:/top/DUT/full \
sim:/top/monitor_interface/fifo_score.full_ref \
sim:/top/DUT/empty \
sim:/top/monitor_interface/fifo_score.empty_ref \
sim:/top/DUT/almostfull \
sim:/top/monitor_interface/fifo_score.almostfull_ref \
sim:/top/DUT/almostempty \
sim:/top/monitor_interface/fifo_score.almostempty_ref \
sim:/top/DUT/underflow \
sim:/top/monitor_interface/fifo_score.underflow_ref \
sim:/top/DUT/mem \
sim:/top/DUT/wr_ptr \
sim:/top/DUT/rd_ptr \
sim:/top/DUT/count  
coverage save fifo_tb.ucdb -onexit 
run -all
#quit -sim
#vcover report fifo_tb.ucdb -all -details -annotate -output out_final.txt





