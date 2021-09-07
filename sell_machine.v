//饮料20元一杯，硬币有5元和10元，考虑找零。1、画FSM，2：写verilog 
module moduleName (
    input clk,
    input rst_n,
    input in_five,
    input in_ten,
    output out_product,
    output out_change
);
    
localparam IDEL = 3'd0;
localparam S0 = 3'd1;
localparam S1 = 3'd2;
localparam S2 = 3'd3;
localparam S3 = 3'd4;
localparam S4 = 3'd5;
    
reg [2:0] cur_state;
reg [2:0] nxt_state;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) cur_state <= IDLE;
    else cur_state <= nxt_state;
end

always @(*) begin
    case(cur_state)
    IDLE: begin
        if(in_five) nxt_state = S0;
        else if(in_ten) nxt_state = S1;
        else nxt_state =  IDLE;
    end
    S0: begin
        if(in_five) nxt_state = S1;
        else if(in_ten) nxt_state = S2;
        else nxt_state =  S0;        
    end
    S1: begin
        if(in_five) nxt_state = S2;
        else if(in_ten) nxt_state = S3;
        else nxt_state =  S1;        
    end
    S2: begin
        if(in_five) nxt_state = S3;
        else if(in_ten) nxt_state = S4;
        else nxt_state =  S2;        
    end
    S2: begin
        if(in_five) nxt_state = S3;
        else if(in_ten) nxt_state = S4;
        else nxt_state =  S2;        
    end
    default: nxt_state = IDLE;
end


assign out_product = (cur_state == S3) || (cur_state == S4);
assign out_change = cur_state == S4;


endmodule

