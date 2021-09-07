// 一、主要解决单比特信号从慢速时钟域（100M）同步到快速时钟域（300M）的问题
// 使用2flop synchronozer

module synchronizer(input data_in,
                    input clk,
                    output )
                    
always @(posedge clk) begin
    if(rst) begin
        reg1 <= 1'b0;
        reg2 <= 1'b0;
    end
    else begin
        reg1 <= data_in;
        reg2 <= reg1;
    end
end



//二、脉冲同步，主要解决单比特信号从快速时钟域（300M）同步到慢速时钟域（100M）的问题
// 不可以使用打两排，会漏掉数据
// 思想将“脉冲信号”转化为“沿信号”
// 缺陷是data_in脉冲间隔至少是两个周期（否则在慢速时钟域会漏掉data_in_temp）
// 解决方案是使用反馈（握手）。

module synchronizer(input data_in,
                    input clka,
                    input clkb,
                    output data_out)
                    
reg data_in_temp; 

always @(posedge clka or negedge rstn_a) begin 
    if(~a_rstn) begin
        data_in_temp <= 1'b0;
    end
    else if(data_in)begin
        data_in_temp <= ~data_in_temp;
    end
end


reg reg1,reg2,reg3;
// 2 flop sync - 1 flop reg
always @(posedge clkb or negedge rstn_b) begin
    if(rst) begin
        reg1 <= 1'b0;
        reg2 <= 1'b0;
        reg3 <= 1'b0;
    end
    else begin
        reg1 <= data_in_temp;
        reg2 <= reg1;
        reg3 <= reg2;
    end
end

assign data_out = reg2 ^ reg3;

