// 找4个数中的最大值

module max(
    input clk,
    input rst_n,
    output [8:0] data_max
)

reg [8:0] data_in [0:3];
reg [8:0] data_max_reg;
reg [1:0] addr;

always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) data_max_reg <= 9'b0;
    else if($(data_max_reg) < $(data_in_current)) 
        data_max_reg <= data_in_current;
end

always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) addr <= 2'b0;
    else if(addr < 2'b11) 
        addr <= addr + 1'b1;
end

assign data_in_current = data_in[addr];
assign data_max = data_max_reg;
endmodule



module max(
    input clk,
    input rst_n,
    output [8:0] data_max
)

reg [8:0] data_in [0:3];
reg [8:0] data_max_1_reg;
reg [8:0] data_max_2_reg;


wire [8:0] data_max_1;
wire [8:0] data_max_2;
wire [8:0] data_max_3;

assign data_max_1 = ($(data_in[0]) < $(data_in[1]))? data_in[1] : data_in[0];
assign data_max_2 = ($(data_in[2]) < $(data_in[3]))? data_in[3] : data_in[2];

always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) begin 
        data_max_1_reg <= 9'b0;
        data_max_2_reg <= 9'b0;
    end
    else begin 
        data_max_1_reg <= data_max_1;
        data_max_2_reg <= data_max_2;

    end
end

assign data_max = ($(data_max_1_reg) < $(data_max_2_reg))? data_max_2_reg : data_max_1_reg;


endmodule



// 如何只用2个比较器？