// 小数分频
// 7/4分频为例
// 计数器 0 4 1 5 2 6 3 0 ...
module divider(
    parameter NUM_DIV = 7;
)( 
    input clk,
    input rst_n,
    output reg clk_div
);

    always @(posedge clk or negedge rst) begin
    if(~rst) 
        cnt <= 3'b0;
    else if(cnt < 3'b3) 
        cnt <= cnt + 3'd4;
    else 
        cnt <= cnt - 3'b3;
    end

    always @(posedge clk or negedge rst) begin
        if(~rst) 
            clk_out <= 1'b0;
        else if(cnt<3'b4) 
            clk_out <= 1'b1;
        else 
            clk_out <= 1'b0;
    end

end