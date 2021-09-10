module binary_to_gray #(
    parameter DATAWIDTH = 1
)(
    input [DATAWIDTH-1:0] data_in,
    output [DATAWIDTH-1:0] data_out;
);
    assign data_out = data_in ^ (data_in >> 1);

endmodule


module gray_to_binary #(
    parameter DATAWIDTH = 1
)(
    input [DATAWIDTH-1:0] data_in,
    output [DATAWIDTH-1:0] data_out;
);

    assign data_out[DATAWIDTH-1] = data_in[DATAWIDTH-1];

    always @(*) begin
        for (int i=DATAWIDTH-2 ; i>-1 ; i--) 
            data_out[i] = data_out[i+1] ^ data_in[i]; 
    end
endmodule
