module binary_to_gray #(
    parameter DATAWIDTH = 1
)(
    input [DATAWIDTH-1:0] data_in,
    output [DATAWIDTH-1:0] data_out;
);
    assign data_out = data_in ^ (data_in >> 1);

endmodule