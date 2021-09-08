//偶数分频
module divider(
    parameter NUM_DIV = 6
)(
    input clk,
    input rst_n,
    output reg clk_div
);
    
    localparam WIDTH = $clog(NUM_DIV);
    localparam [WIDTH-1:0] cnt_max = NUM_DIV / 2 - 1;
    reg    [WIDTH-1:0] cnt;
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            cnt <= 'b0;
        else if(cnt >= cnt_max)
            cnt <= 'b0;
        else 
            cnt <= cnt + 1'b1;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            clk_div <= 1'b0;
        else if(cnt == cnt_max)
            clk_div <= ~clk_div;
    end

 endmodule