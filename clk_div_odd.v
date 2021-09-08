//奇数分频
module divider(
    parameter NUM_DIV = 7;
)( 
    input clk,
    input rst_n,
    output reg clk_div
);

    localparam WIDTH = $clog(NUM_DIV);

    reg clk_div;
    reg[WIDTH-1:0] cnt1;
    reg[WIDTH-1:0] cnt2;
    reg    clk_div1, clk_div2;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt1 <= 'b0;
        else if(cnt1 >= NUM_DIV - 1)        
            cnt1 <= 'b0;    
        else 
            cnt1 <= cnt1 + 1'b1;
        else 
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            clk_div1 <= 1'b1;
        else if(cnt1 < NUM_DIV / 2) 
            clk_div1 <= 1'b1;
        else
            clk_div1 <= 1'b0;
    end
     
    always @(negedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt2 <= 'b0;
        else if(cnt2 >= NUM_DIV - 1)        
            cnt2 <= 'b0;    
        else 
            cnt2 <= cnt2 + 1'b1;
        else 
    end

    always @(negedge clk or negedge rst_n) begin
        if(!rst_n)
            clk_div2 <= 1'b1;
        else if(cnt2 < NUM_DIV / 2) 
            clk_div2 <= 1'b1;
        else
            clk_div2 <= 1'b0;
    end

    assign clk_div = clk_div1 | clk_div2;
endmodule