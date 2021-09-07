//3、设计一个电路，使用时序逻辑对一个单bit信号进行毛刺滤除操作。
//高电平或者低电平宽度小于4个时钟周期的为毛刺。用Verilog或者VHDL写出代码。（大疆FPGA逻辑岗B卷）


//思路：检测到data_in的沿后，重0开始计数，当计数器大于3，证明没有毛刺，可以输出


module filter(input data_in,
              input clk,
              input rstn,
              output data_out)

// 沿检测  data_edge 为1 代表出现边沿
reg data_in_reg;

always @(posedge clk or negedge rstn) begin
    if(~rstn) begin
        data_in_reg <= 1'b0;
    end
    else begin
        data_in_reg <= data_in;
    end
end

assign data_edge = data_in_reg ^ data_in;



reg [2:0] cnt;
always @(posedge clk or  negedge rstn) begin
    if(~rstn) begin
        cnt <= 'd0;
    end
    else if(data_edge) begin     
        cnt <= 'd0;        
    end
    else if(cnt < 3'd4)
        cnt <= cnt + 1'b1; 
    else      
end


always @(posedge clk or negedge rst) begin
    if(~rstn) begin
        data_out =  1'b0;
    end
    else if(cnt==3'd4) begin
        data_out =  data_in;        
    end
end