// huawei 红绿灯 绿60s，黄5s，红30s，给定时钟1MHz
module moduleName #(
    parameter green = 60;
    parameter yellow = 5;
    parameter red = 30;
)(
    input clk,
    input rst_n,
    output [2:0] out_data
);


localparam WIDTH = $clog(1000000*(green+yellow+red));  
localparam [WIDTH-1:0] cnt_green = 1000000*green;
localparam [WIDTH-1:0] cnt_yellow = cnt_green + 1000000*yellow;
localparam [WIDTH-1:0] cnt_red = cnt_yellow + 1000000*red;
reg [WIDTH-1:0] cnt;

always @(posedge clk or negedge rst_n) begin
   if(!rst_n) cnt <= {WIDTH{1'b0}};
   else if(cnt == cnt_red) cnt <= {WIDTH{1'b0}}; 
   else cnt <= cnt + 1'b1;
end

localparam IDLE = 2'd0;
localparam S0 = 2'd1;
localparam S1 = 2'd2;
localparam S2 = 2'd3;

reg [1:0] cur_state;
reg [1:0] nxt_state;

always @(posedge clk or negedge rst_n) begin
   if(!rst_n) cur_state <= IDLE;
   else cur_state <= nxt_state;
end

always @(*) begin
    case(cur_state) 
    IDLE: nxt_state = S0;
    S0: begin
        if(cnt == cnt_green) nxt_state = S1;
        else nxt_state = S0;
    end
    S1: begin
        if(cnt == cnt_yellow) nxt_state = S2;
        else nxt_state = S1;        
    end
    S2: begin
        if(cnt == cnt_red) nxt_state = S0;
        else nxt_state = S2;        
    end    
    endcase
end

assign data_out[0] = cur_state == S0;
assign data_out[1] = cur_state == S1;
assign data_out[2] = cur_state == S2;


endmodule