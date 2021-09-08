// https://mp.weixin.qq.com/s/82o9iAIw1LiDsjBNmiBVDQ

// 固定bit写法
module fixed_prio_arb
  (
    input [2:0]         req,
    output logic [2:0]  grant
  );

  always @(posedge clk) begin
    if(req[0]) grant = 3'b001;
    else if(req[1]) grant = 3'b010;
    else if(req[2]) grant = 3'b100;
    else grant = 3'b000;
  end
endmodule

// 解法2：减1，取反，相与：找最低bit的1
module prior_arb #(
parameter WIDTH = 16
) (
input  [WIDTH-1:0]     req,
output [WIDTH-1:0]     gnt
);

wire  [WIDTH-1:0] var;
assign var = req - 1'b1;
assign gnt = req & ~var;

endmodule
