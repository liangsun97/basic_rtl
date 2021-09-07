// 计算32bit数据，从MSB开始，有多少比特连续的0
// https://stackoverflow.com/questions/2368680/count-leading-zero-in-single-cycle-datapath

//下面代码忽略了输入为全零的情况
module moduleName (
    input [31:0] data_in,
    output [4:0] count
);

    wire [15:0] var_16;
    wire [7:0] var_8;
    wire [3:0] var_4;
    wire [1:0] var_2;

    assign count[4] = ~ | data_in[31:16];
    assign var_16 = count[4] ? data_in[15:0] : data_in[31:16];
    assign count[3] = ~ | var_16[15:8];
    assign var_8 = count[3] ? var_16[7:0] : var_16[15:8];
    assign count[2] = ~ | var_8[7:4];
    assign var_4 = count[2] ? var_8[3:0] : var_8[7:4];
    assign count[1] = ~ | var_4[3:2];
    assign var_2 = count[1] ? var_4[1:0] : var_4[4:3];
    assign count[0] = ~ var_2[1];
 
endmodule

//考虑输入为全零的情况
module moduleName (
    input [31:0] data_in,
    output [5:0] count_out
);
    wire [4:0] count;
    wire [15:0] var_16;
    wire [7:0] var_8;
    wire [3:0] var_4;
    wire [1:0] var_2;


    assign count[4] = ~ | data_in[31:16];
    assign var_16 = count[4] ? data_in[15:0] : data_in[31:16];
    assign count[3] = ~ | var_16[15:8];
    assign var_8 = count[3] ? var_16[7:0] : var_16[15:8];
    assign count[2] = ~ | var_8[7:4];
    assign var_4 = count[2] ? var_8[3:0] : var_8[7:4];
    assign count[1] = ~ | var_4[3:2];
    assign var_2 = count[1] ? var_4[1:0] : var_4[4:3];
    assign count[0] = ~ var_2[1];
 
    assign count_out =  (data_in == 32'd0) ? 6'd32 : {1'b0,count};

endmodule