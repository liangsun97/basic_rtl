module moduleName (
    input clk,
    input rst_n,
    output reg rst_n_out
);
    
    reg rst_n_d1;

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            rst_n_d1 <= 1'b0;
            rst_n_out <= 1'b0;
        end
        else begin
            rst_n_d1 <= 1'b1;
            rst_n_out <= rst_n_d1;
        end
    end


endmodule
