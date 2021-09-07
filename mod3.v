// if a serial input vector can be divided by 3, output 1'b1
// 0,1,2
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
   IDLE: begin
                if(~data_in) n_state = S0;
                else n_state = S1; 
            end 
   S0: begin
                if(~data_in) n_state = S0;
                else n_state = S1; 
            end 
   S1: begin
                if(~data_in) n_state = S2;
                else n_state = S0; 
            end
   S2: begin
                if(~data_in) n_state = S1;
                else n_state = S2; 
            end
   endcase
end

assign data_out = c_state == S0;
endmodule
