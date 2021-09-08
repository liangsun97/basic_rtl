// nvidia笔试题：data_out contains 4 bytes data from the same position but in different input cycle.(i.e., output cycle 0 contains the lowest
// bytes from input cycle 0 to 3. .... output cycle 3 contains the highest bytes from input cycle 0 to 3.... 
// output cycle 4 contains the lowest bytes from input cycle 4 to 7. .... ) 

module moduleName (
    input clk,
    input rst_n,
    input [31:0] data_in,
    input in_vld,
    output [31:0] data_out,
    output out_vld
);

reg [31:0] data_reg [0:7]

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0; i<8; i++)
            data_reg[i] <= 32'd0;
    end
    else if(in_vld)
        data_reg[wr_addr] <= data_in;
end

reg [2:0] wr_addr;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        wr_addr <= 3'd0;
    else if(in_vld)
        wr_addr <= wr_addr + 1'b1;
end



reg [2:0] cnt_1;
reg [2:0] cnt_2;


always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt_1 <= 'd0;
    else if(cnt_1 == 3'd4)
        cnt_1 <= 'd0;
    else if((wr_addr == 3'd4) || (cnt_1 >0))
        cnt_1 <= cnt_1 + 1'b1;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt_2 <= 'd0;
    else if(cnt_2 == 3'd4)
        cnt_2 <= 'd0;
    else if((wr_addr == 3'd8) || (cnt_2 >0))
        cnt_2 <= cnt_2 + 1'b1;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        out_vld <= 'd0;
    else if(cnt_1 > 0 || cnt_2 > 0 )
        out_vld <= 'd1;
    else out_vld <= 'd0;
end


assign data_out = cnt_1 > 0 ? {data_reg[3][8*cnt_1-1 : 8*(cnt_1-1)], data_reg[3][8*cnt_1-1 : 8*(cnt_1-1)], data_reg[3][8*cnt_1-1 : 8*(cnt_1-1)],data_reg[3][8*cnt_1-1 : 8*(cnt_1-1)]} :
                                         {data_reg[7][8*cnt_2-1 : 8*(cnt_2-1)], data_reg[6][8*cnt_2-1 : 8*(cnt_2-1)], data_reg[5][8*cnt_2-1 : 8*(cnt_2-1)],data_reg[4][8*cnt_2-1 : 8*(cnt_2-1)]};

endmodule