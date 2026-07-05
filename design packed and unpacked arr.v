module array_always_basic_practice (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [7:0]  data_in,
    input  logic [1:0]  w_row,
    input  logic [1:0]  w_col,
    input  logic [1:0]  r_row,
    input  logic [1:0]  r_col,
    
    output logic [7:0]  comb_out,
    output logic [7:0]  seq_out,
    output logic [15:0] row_sum
);

    logic [7:0] matrix [3][3];

   
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            matrix <= '{default: 8'h00};
            seq_out <= 8'h00;
        end else begin
            matrix[w_row][w_col] <= data_in;
            seq_out <= matrix[r_row][r_col];
        end
    end

  
    always @(*) begin
        comb_out = matrix[r_row][r_col];
        row_sum = matrix[r_row][0] + matrix[r_row][1] + matrix[r_row][2];
    end

endmodule
