//用moore型状态机实现序列“1101”从右到左的不重叠检测。
//（注：典型的状态机设计分为moore与mealy两大类，其中mealy状态机的输出不仅与当前状态值有关，而且与当前输入有关；
// moore状态机的输出仅与当前状态值有关，而与此时的输入无关）（大疆FPGA逻辑岗A卷）

module sequence_detecter(input clk,
                         input rst,
                         input data_in,
                         output data_out)


parameter s0=3'd0, s1=3'd01......
reg [2:0] c_state, n_state;

always @(posedge clk or negedge rst) begin
    if(~rst) begin
        c_state <= s0;
    end
    else begin
        c_state <= n_state;
    end
end


always @(*) begin
    case(c_state) 
    s0: c_state = data_in? s1 : s0;

    endcase
end

assign data_out = c_state == s4;


endmodule                         