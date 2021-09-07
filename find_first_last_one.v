// 找出32bit vector 第一个1/最后一个1


//从MSB开始，第一个1
module moduleName (
    input [7:0] data_in,
    output [2:0] count
);

    wire [3:0] var_4;
    wire [1:0] var_2;

    assign count[2] = | data_in[7:3];
    assign var_4 = count[2] ? data_in[7:4] : data_in[3:0];
    assign count[1] = | var_4[3:2];
    assign var_2 = count[1] ? var_4[3:2] : var_4[1:0];
    assign count[0] = var_2[1];

    //assign count_out = (data_in == 8'd0) ? 3'd0 : 

endmodule


//  从MSB开始，最后一个1
module moduleName (
    input [7:0] data_in,
    output [2:0] count
);
    
    wire [3:0] var_4;
    wire [1:0] var_2;

    assign count[2] = | data_in[3:0];
    assign var_4 = count[2] ? data_in[3:0] : data_in[7:4];
    assign count[1] = | var_4[1:0];
    assign var_2 = count[1] ? var_4[1:0] : var_4[3:2];
    assign count[0] = var_2[0];

    //assign count_out = (data_in == 8'd0) ? 3'd0 : 

endmodule