module gray_to_binary #(
    parameter DATAWIDTH = 1
)(
    input [DATAWIDTH-1:0] data_in,
    output [DATAWIDTH-1:0] data_out;
);

    assign data_out[DATAWIDTH-1] = data_in[DATAWIDTH-1];

    always @(*) begin
        for (int i=DATAWIDTH-2 , i>-1 , i--) begin
            data_out[i] = data_out[i] ^ data_out[i-1]; 
        end
    end
endmodule




// 或者 
module gray_to_binary #(
    parameter int N = -1
)(
    input  logic [N-1:0] A,
    output logic [N-1:0] Z
);
    for (genvar i = 0; i < N; i++)
        assign Z[i] = ^A[N-1:i];
endmodule