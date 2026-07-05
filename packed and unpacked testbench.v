module testbench;
    logic        t_clk;
    logic        t_rst_n;
    logic [7:0]  t_data_in;
    logic [1:0]  t_w_row;
    logic [1:0]  t_w_col;
    logic [1:0]  t_r_row;
    logic [1:0]  t_r_col;
    
    logic [7:0]  t_comb_out;
    logic [7:0]  t_seq_out;
    logic [15:0] t_row_sum;

    
    array_always_basic_practice dut (
        .clk      (t_clk),
        .rst_n    (t_rst_n),
        .data_in  (t_data_in),
        .w_row    (t_w_row),
        .w_col    (t_w_col),
        .r_row    (t_r_row),
        .r_col    (t_r_col),
        .comb_out (t_comb_out),
        .seq_out  (t_seq_out),
        .row_sum  (t_row_sum)
    );
  
  initial
    t_clk =1'b0;
  
    always #5 t_clk = ~t_clk;
  
  initial
    begin
      
      $monitor("Time=%0t | RST=%b | WRITE: [%0d][%0d]=%h | READ Ptr: [%0d][%0d] | comb_out=%h | seq_out=%h | row_sum=%d", 
                 $time, t_rst_n, t_w_row, t_w_col, t_data_in, t_r_row, t_r_col, t_comb_out, t_seq_out, t_row_sum);
      
      t_rst_n =1'b0;
      t_data_in =8'b00000000;
      t_w_row =2'b00;
      t_w_col =2'b00;
      t_r_row =2'b00;
      t_r_col =2'b00;
      #15;
      
      t_rst_n =1'b1;
      t_data_in =8'b11111110;
      t_w_row = 2'b10;
      t_w_col = 2'b10;
      #10;
      
      t_data_in =8'b11111110;
      t_w_row = 2'b00;
      t_w_col = 2'b01;
      #10;
      
      t_r_row =2'b00;
      t_r_col =2'b01;
      #5;
      
      t_r_row =2'b00;
      t_r_col =2'b01;
      #5;
      $finish;
      
    end
endmodule
      
        
      
