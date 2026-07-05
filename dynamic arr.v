module array_practice (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [7:0]  vector_a [4], 
    input  logic [7:0]  vector_b [4], 
    output logic [8:0]  vector_sum [4],
    output logic [15:0] total_accum
);

    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            foreach (vector_sum[i]) begin
                vector_sum[i] <= '0;
            end
            
            
            total_accum <= '0;
            
        end else begin
            
            for (int i = 0; i < 4; i++) begin
                vector_sum[i] <= vector_a[i] + vector_b[i];
                total_accum   <= total_accum + (vector_a[i] * vector_b[i]);
            end
          
        end
    end

endmodule
