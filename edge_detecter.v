module edge_detecter(input data_in,
                    input clk,
                    output rise_edge,
                    output fallen_edge,
                    output double_edge)

reg reg1,reg2,reg3;
// 2 flop sync - 1 flop reg
always @(posedge clk) begin
    if(rst) begin
        reg1 <= 1'b0;
        reg2 <= 1'b0;
        reg3 <= 1'b0;
    end
    else begin
        reg1 <= data_in;
        reg2 <= reg1;
        reg3 <= reg2;
    end
end

assign rise_edge = reg2 & ~reg3;
assign fallen_edge = ~reg2 & reg3;
assign double_edge = reg2 ^ reg3;
