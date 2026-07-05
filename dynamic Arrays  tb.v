module array_practice_tb;
  
    logic        clk;
    logic        rst_n;
    logic [7:0]  vector_a [4];
    logic [7:0]  vector_b [4];
    logic [8:0]  vector_sum [4];
    logic [15:0] total_accum;

    
    array_practice dut (
        .clk(clk),
        .rst_n(rst_n),
        .vector_a(vector_a),
        .vector_b(vector_b),
        .vector_sum(vector_sum),
        .total_accum(total_accum)
                       );

   
    always #5 clk = ~clk;

    
    initial
      begin
 
        clk = 0;
        rst_n = 0; 
 
        foreach (vector_a[i]) vector_a[i] = '0;
        foreach (vector_b[i]) vector_b[i] = '0;
        #15;
        
        rst_n = 1; 
        #5;

        $display(" Test Case 1 Starting");
       
      
        vector_a = '{8'd7, 8'd6, 8'd6, 8'd9};
        vector_b = '{8'd7, 8'd8, 8'd17, 8'd11};
        
       
        @(posedge clk); 
        #1; 
      
      
        $display("[TB] vector_sum: [0]=%d, [1]=%d, [2]=%d, [3]=%d", 
                  vector_sum[0], vector_sum[1], vector_sum[2], vector_sum[3]);
        $display("[TB] total_accum: %d", total_accum);

        #20;

       
        $display("Test Case 2 (Random Data)");
        @(posedge clk);
      
        foreach (vector_a[i]) begin
          vector_a[i] = $urandom_range(5, 10); 
          vector_b[i] = $urandom_range(1,18);
        end
        @(posedge clk);
        #1;
        
        $display("[TB] Random vector_sum: [0]=%d, [1]=%d, [2]=%d, [3]=%d", 
                  vector_sum[0], vector_sum[1], vector_sum[2], vector_sum[3]);
        $display("[TB] Random total_accum: %d", total_accum);

        #50;
        $finish; 
      
    end

  
    initial
      begin
        
        $dumpfile("dump.vcd");
        $dumpvars(0, array_practice_tb);
        
    end

endmodule
