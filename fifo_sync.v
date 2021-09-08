module moduleName (
    parameter WIDTH = 32,
    parameter LENGTH = 32
)
(
    input clk,
    input rst_n,
    input push,
    input pop,
    input [WIDTH-1 : 0] data_in,
    output [WIDTH-1 : 0] data_out，
    output full,
    output empty
);
    localparam ADDR_WIDTH = $clog(LENGTH);

    reg [WIDTH-1:0] mem [0:LENTH];
    reg [ADDR_WIDTH:0] wr_addr;
    reg [ADDR_WIDTH:0] rd_addr;
    wire full;
    wire empty;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)  
            wr_addr <= 'd0;
        else if(push & ~full)
            wr_addr <= wr_addr + 1'b1;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)  
            rd_addr <= 'd0;
        else if(pop & ~empty)
            rd_addr <= rd_addr + 1'b1;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)  begin
            for(i=0;i<LENGTH;i++)
                mem[i] <= 'd0;
        end
        else if(push & ~full)
            mem[wr_addr[ADDR_WIDTH-1:0]] <= data_in;
    end

    data_out = mem[rd_addr[ADDR_WIDTH-1:0]];

    assign full = (wr_addr[ADDR_WIDTH] ^ rd_addr[ADDR_WIDTH]) &&  (wr_addr[ADDR_WIDTH-1:0] == rd_addr[ADDR_WIDTH-1:0])
    assign empty = wr_addr[ADDR_WIDTH:0] == rd_addr[ADDR_WIDTH:0];


endmodule