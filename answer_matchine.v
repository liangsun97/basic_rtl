//
module MODULENAME (
parameter WIDTH = 5
)(
    input clk,
    input rst_n,
    input butten,
    input trigger
    input [WIDTH-1 : 0] others,
    output red,
    output yellow,
    output green,
    output out_butten
)

always @(posedge clk or negedge rst_n) begin
    if(rst_n) cnt <= 10'd0;
    else if(rst_cnt) 
        cnt <= 10'd0;
    else if(cnt == 10'd1000)
        cnt <= cnt;
    else if(trigger) 
        cnt <= cnt + 1'b1;
end

localparam IDLE = 3'd0;
localparam s_yellow = 3'd1;
localparam s_green = 3'd2;
localparam s_red = 3'd3;
localparam s_0 = 3'd4;


reg [2:0] cur_state;
reg [2:0] nxt_state;
always @(posedge clk or negedge rst_n) begin
    if(rst_n) cur_state <= IDLE;
    else cur_state <= nxt_state;
end


always @(*) begin
    case(cur_state) 
    IDLE: nxt_state = s0;
    s0: begin
        if((cnt<10'd1000) && butten && (~|others))
            nxt_state = s_green;
        else if((cnt<10'd1000) && butten && (|others))
            nxt_state = s_yellow;
        else if(cnt==10'd1000)
            nxt_state = s_red;
    end
    s_green : nxt_state = s_green;
    s_red: nxt_state = s_red;
    s_yellow: nxt_state = IDLE;
    default: nxt_state = IDLE;
    endcase
end

assign trigger = cur_state == s0;
assign rst_cnt = cur_state == s_yellow;

assign green = cur_state == s_green;
assign red = cur_state == s_red;
assign yellow = cur_state == s_yellow;

assign out_butten = butten && (cur_state != s_red);


endmodules