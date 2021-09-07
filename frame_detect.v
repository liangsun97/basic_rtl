// https://blog.nowcoder.net/n/a23e0d1a6d484812945515cc273926a2
// 帧头检测，frame_head来脉冲的同时din会来数据，连续三次数据都是8'h23的话，就输出一个脉冲。

module moduleName (
    input clk,
    input rst_n,
    input frame_head,
    input [7:0] din,
    output detect
);
    localparam IDLE = 2'd0;
    localparam s0 = 2'd1;
    localparam s1 = 2'd2;
    localparam s2 = 2'd3;

    reg [1:0] cur_state;
    reg [1:0] nxt_state;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            cur_state <= IDLE;
        else 
            cur_state <= nxt_state;    
    end

    always @(*) begin
        case(cur_state) 
        IDLE: begin 
                    if(frame_head && din == 8'h32) 
                        nxt_state = s0;
                    else 
                        nxt_state = IDLE;
                end
        s0: begin 
                    if(frame_head && din == 8'h32) 
                        nxt_state = s1;
                    else 
                        nxt_state = s0;
                end
        s1: begin 
                    if(frame_head && din == 8'h32) 
                        nxt_state = s2;
                    else 
                        nxt_state = s1;
                end
        s2: nxt_state = IDLE;
        default: nxt_state = IDLE;
        endcase
    end 

    assign detect = cur_state == s2;

endmodule