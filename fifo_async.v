module moduleName (
    parameter WIDTH = 32,
    parameter LENGTH = 32
)
(
    input clkw,
    input rstn_w,
    input clkr,
    input rstn_r,
    input push,
    input pop,
    input [WIDTH-1 : 0] data_in,
    output [WIDTH-1 : 0] data_out
    output full,
    output empty
);
    localparam ADDR_WIDTH = $clog(LENGTH);

    reg [ADDR_WIDTH:0] wr_addr;
    wire [ADDR_WIDTH:0] wr_addr_gray;
    reg [ADDR_WIDTH:0] wr_addr_gray_d1;
    reg [ADDR_WIDTH:0] wr_addr_gray_d2;
    reg [ADDR_WIDTH:0] rd_addr;
    wire [ADDR_WIDTH:0] rd_addr_gray;
    reg [ADDR_WIDTH:0] rd_addr_gray_d1;
    reg [ADDR_WIDTH:0] rd_addr_gray_d2;
    wire full;
    wire empty;
    wire wr_en;
    wire rd_en;

    sram U_sram(
        .clkw(clkw),
        .clkr(clkr),
        .wr_addr(wr_addr[ADDR_WIDTH-1:0]),
        .rd_addr(rd_addr[ADDR_WIDTH-1:0]),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .D(data_in),
        .Q(data_out),
    );

    always @(posedge clkw or negedge rstn_w) begin
        if(!rstn_w)  
            wr_addr <= 'd0;
        else if(push & ~full)
            wr_addr <= wr_addr + 1'b1;
    end

    always @(posedge clkr or negedge rstn_r) begin
        if(!rstn_r)  
            rd_addr <= 'd0;
        else if(pop & ~empty)
            rd_addr <= rd_addr + 1'b1;
    end

    assign wr_addr_gray = wr_addr ^ (wr_addr>>1);
    assign rd_addr_gray = rd_addr ^ (rd_addr>>1);

    always @(posedge clkr or negedge rstn_r) begin
        if(!rstn_r)  begin
            wr_addr_gray_d1 <= 'd0;
            wr_addr_gray_d2 <= 'd0;            
        end
        else begin
            wr_addr_gray_d1 <= wr_addr_gray;
            wr_addr_gray_d2 <= wr_addr_gray_d1;
        end
    end

    always @(posedge clkw or negedge rstn_w) begin
        if(!rstn_w)  begin
            rd_addr_gray_d1 <= 'd0;
            rd_addr_gray_d2 <= 'd0;            
        end
        else begin
            rd_addr_gray_d1 <= rd_addr_gray;
            rd_addr_gray_d2 <= rd_addr_gray_d1;
        end
    end

    assign full = (~rd_addr_gray_d2[ADDR_WIDTH:ADDR_WIDTH-1] == wr_addr_gray[ADDR_WIDTH:ADDR_WIDTH-1]) && 
                        rd_addr_gray_d2[ADDR_WIDTH-2:0] == wr_addr_gray[ADDR_WIDTH-2:0];
    assign empty = rd_addr_gray == wr_addr_gray_d2;


    assign wr_en = push && ~full;
    assign rd_en = pop && ~empty;

endmodule