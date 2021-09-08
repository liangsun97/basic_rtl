 // 4 bit round robin arbiter
 module rr_arbiter(
 input clk,
 input rst_n,
 input [3:0] req,
 output reg [3:0] gnt
 ) 

 always@(posedge clk or negedge rst_n) begin
   if(~rst_n) gnt = 4'd0;
   else begin 
     case(gnt)
       4'b0001: begin 
         if(req[1])         gnt <= 4'b0010;
         else if(req[2])  gnt <= 4'b0100;
         else if(req[3])  gnt <= 4'b1000;
         else if(req[0])  gnt <= 4'b0001;
         else gnt <= 4'b0000;
       end 
       4'b0010: begin 
         if(req[2])         gnt <= 4'b0100;
         else if(req[3])  gnt <= 4'b1000;
         else if(req[0])  gnt <= 4'b0001;
         else if(req[1])   gnt <= 4'b0010;
         else gnt <= 4'b0000;
       end
       4'b0100: begin 
         if(req[3])         gnt <= 4'b1000;
         else if(req[0])  gnt <= 4'b0001;
         else if(req[1])   gnt <= 4'b0010;
         else if(req[2])  gnt <= 4'b0100;
         else gnt <= 4'b0000;
       end
       4'b1000: begin 
         if(req[0])         gnt <= 4'b0001;;
         else if(req[1])  gnt <= 4'b0010;
         else if(req[2])  gnt <= 4'b0100;
         else if(req[3])  gnt <= 4'b1000;
         else gnt <= 2'd3;
       end
       default: begin        
         if(req[0])         gnt <= 4'b0001;;
         else if(req[1])  gnt <= 4'b0010;
         else if(req[2])  gnt <= 4'b0100;
         else if(req[3])  gnt <= 4'b1000;
         else gnt <= 2'd3;
       end
     endcase 
   end
 end
 
 endmodule