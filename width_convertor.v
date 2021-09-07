// http://bbs.eetop.cn/thread-402941-1-1.html

module top
(
    input clka,
    input clkb,
    input rst_n,
    input wra_n,
    input da,
    output wrb,
    output reg [7:0]db
);
// =============== Main Code Start ===============
reg [7:0]   shift_reg;
reg           wra_n_d1;
reg           wra_n_d2;
reg           wra_n_d3;
wire          rising_wra_n;


always @(posedge clka or negedge rst_n) begin
    if (rst_n) begin
        shift_reg <= 8'd0;
    end
    else if(!wra_n) 
        shift_reg <= {shift_reg[6:0], da};
end

always @(posedge clkb or negedge rst_n) begin
    if (rst_n) begin
        wra_n_d1 <= 1'd1;
        wra_n_d2 <= 1'd1;
        wra_n_d3 <= 1'd1;
    end
    else begin
        wra_n_d1 <= wra_n;
        wra_n_d2 <= wra_n_d1;       
        wra_n_d3 <= wra_n_d2;       
    end
end

assign rising_wra_n = wra_n_d2 & !wra_n_d3;

always @(posedge clkb or negedge rst_n) begin
    if (rst_n) begin
        db <= 8'd0;
    end
    else if(rising_wra_n) 
        db <= shift_reg;
end

endmodule