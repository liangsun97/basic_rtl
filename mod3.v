// 序列模三（整除3）检测器
// https://blog.csdn.net/darknessdarkness/article/details/105734337?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522163106765916780274188649%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fall.%2522%257D&request_id=163106765916780274188649&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~first_rank_ecpm_v1~rank_v29_ecpm-1-105734337.first_rank_v2_pc_rank_v29&utm_term=verilog+3%E6%95%B4%E9%99%A4&spm=1018.2226.3001.4187

// if a serial input vector can be divided by 3, output 1'b1
// 余数可能是0, 1, 2。分别用s0, s1, s2表示
//               0          1
// IDLE       S0        S1
// S0          S0        S1
// S1           S2        S0 
// S2           S1        S2

module moduleName (
    input clk,
    input rst_n,
    input data_in,
    output data_out
);

localparam IDLE = 2'd0; 
localparam S0 = 2'd1; 
localparam S1 = 2'd2; 
localparam S2 = 2'd3; 
reg [1:0] c_state;
reg [1:0] n_state;


always @(posedge clk or negedge rst_n) begin
   if(~rst_n) begin
       c_state <= IDLE;
   end 
   else begin
       c_state <= n_state;
   end
end

always @(*) begin
   case(c_state) 
   IDLE: n_state = data_in ? S1 : S0;
   S0: n_state = data_in ? S1 : S0;
   S1: n_state = data_in ? S0 : S2;
   S2: n_state = data_in ? S2 : S1;
   default: n_state = IDLE;
   endcase
end

assign data_out = c_state == S0;
endmodule
