//https://zhuanlan.zhihu.com/p/141939225
//用verilog实现串并转换电路，上游moduleA每次向s_to_p（串并转换）发送1bit数据，
//它将moduleA发送的6个数据组装成6bit信号，用一个时钟周期发送给moduleB。
//moduleA与s_to_p之间是valid-ready握手协议，moduleB与s_to_p之间是valid-only握手协议，数据组装时先发的数据放到data_out的低位。
module moduleName #(
    parameters WIDTH = 6
) (
    input clk,
    input rst_n,
    input data_in,
    input vld_in,
    output rdy_in,
    output reg [WIDTH-1:0] data_out,
    output vld_out,
    input rdy_out
);

localparam COUNTER_WIDTH = $clog(WIDTH);

always @(posedge clk or negedge rst_n) begin
    if(rst_n) begin
        cnt <= {COUNTER_WIDTH{1'b0}};
    end
    else if(cnt_clr) begin
        cnt <= {COUNTER_WIDTH{1'b0}};        
    end
    else if(vld_in && rdy_in) begin
        cnt <= cnt + 1'b1;
    end
end

assign cnt_clr = vld_out  && rdy_out;
assign rdy_in = cnt == COUNTER_WIDTH'd(WIDTH);
assign vld_out = ~rdy_in;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        shift_reg <=  {WIDTH{1'b0}};
    end
    else if(vld_in && rdy_in) begin
        shift_reg <= {data_in, shift_reg[WIDTH-1:1]}
    end
end

assign data_out = shift_reg;


endmodule
