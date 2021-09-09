// 找到当前数据流中最大的两个数

module find_large_number(
input clk, rst_n,           //clock and reset
input in_vld,                //if set, the in_data is valid
input [31:0] in_data,     //input data stream
input in_clr,                 //if set, clear and invalidate the recorded largest values
output reg [31:0] out_1st_largest,  //largest captured number
output reg [31:0] out_2nd_largest); //second largest captured number
  
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        out_1st_largest <= 'b0;
        out_2st_largest <= 'b0;
    end 
    else if(in_clr) begin
        out_1st_largest <= 'b0;
        out_2st_largest <= 'b0;
  	end 
    else if(in_vld) begin
        if(in_data > out_1st_largest) begin
            out_1st_largest <= in_data;
            out_2st_largest <= out_1st_largest;
        end 
        else if(in_data > out_2st_largest) begin
            out_2st_largest <= in_data;
        end 
    end
end  

endmodule