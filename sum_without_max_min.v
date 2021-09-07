//https://blog.csdn.net/wangn1633/article/details/108569674
//剔除最大最小值并求累加
//有一个模块，vaild会连续拉高，同时有16bit数据进来，vaild连续拉高的周期数为3-255，
//然后要把这些数据求和，但是要把最大和最小的数剔除，最后done和sum一起输出。

module moduleName (
    input clk,
    input rst_n,
    input vld,
    input [15:0] data_in,
    output reg [23:0] sum,
    output reg done,
);  

    reg [23:0] sum_all;
    reg vld_d1;
    wire fallen_vld;
    reg fallen_vld_d1;
    reg [15:0] max;
    reg [15:0] min;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            sum_all <= 'd0;
        else if(vld)
            sum_all <= sum_all + {8'd0, data_in};
    end


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            vld_d1 <= 'd0;
        else 
            vld_d1 <=  vld;
    end    

    assign fallen_vld = !vld & vld_d1;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            fallen_vld_d1 <= 'd0;
        else 
            fallen_vld_d1 <=  fallen_vld;
    end    

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            max <= 16'h0;
        else if(vld & (data_in > max))
            max <= data_in;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            min <= 16'hffff;
        else if(vld & (data_in < min))
            min <= data_in;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            sum <= 'd0;
        else if(fallen_vld)
            sum <= sum_all - max;
        else if(fallen_vld_d1)
            sum <= sum - min;        
    end
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            done <= 'd0;
        else if(fallen_vld_d1)
            done <= 1'd1;
        else 
            done <= 'd0;
    end    

endmodule