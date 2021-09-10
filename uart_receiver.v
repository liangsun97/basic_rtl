// Ref: https://blog.csdn.net/qq_40789587/article/details/84073419
// uart接收器，输入数据是15200波特率，时钟是1M，输出FIFO位宽是8bit，
// 过来的Uart信号默认是一直拉高的，拉低表示开始传数据了，然后有个结束信号

// 10^6 / 15200 = 

module moduleName (
    input clk,
    input rst_n,
    input data_in,       //拉低时表示开始传输
    input full,             //后级FIFO满标志
    output wr_en,       //表示把这组数据往FIFO里写
    output [7:0] data_out 
);
    
    localparam WIDTH = $clog(10000000/15200);
    localparam [WIDTH-1 :0] CNT = 10000000/15200 ;
    reg [WIDTH-1 :0] cnt_1;
    reg [2:0] cnt_2;
    reg start;
    reg data_in_d1;


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            data_in_d1 <= 1'b1;
        else 
            data_in_d1 <= data_in;
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) 
            start <= 'b0;
        else if(~data_in && data_in_d1)
            start <= 'b1;
        else if(cnt_2 == 3'd7))
            start <= 'b0;
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) 
            cnt_1 <= 'b0;
        else if(cnt_1 == CNT)
            cnt_1 <= 'b0;
        else if(start)
            cnt_1 <= cnt_1 + 1'b1;
        else 
            cnt_1 <= 'b0;
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) 
            cnt_2 <= 'b0;
        else if(cnt_2 == 3'd7)
            cnt_2 <= 'b0;
        else if(cnt_1 == CNT)
            cnt_2 <= cnt_2 + 1'b1;
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) 
            data_out <= 8'b0;
        else if(cnt_1 == CNT/2)
            data_out <= {data_in, data_out[7:1]};
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) 
            wr_en <= 1'b0;
        else if(~full && cnt_2==3'd7 && cnt_1==CNT)
            wr_en <= 1'b1;
    end

endmodule
