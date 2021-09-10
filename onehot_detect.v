// method 1
module moduleName  (
    parameter WIDTH = 2;
) (
    input [WIDTH-1:0] a,
    output a_is_onehot
);
    
reg [WIDTH-1:0] q ;

always @(*) begin
    q[0] = a[0];
    for(i=1; i<=WIDTH-1;i++)
        q[i] = q[i-1] ^ a[i];
end

assign a_is_onehot = (&(~a | q)) && (q[WIDTH-1-1]);

endmodule


// method 2
module onehot_2bit  (
) (
    input [1:0] a,
    output a_is_onehot,
    output a_is_allzero
);

    assign a_is_onehot = a[1] ^ a[0];
    assign a_is_allzero = ~(a[1] | a[0]);

endmodule


module onehot_4bit  (
) (
    input [3:0] a,
    output a_is_onehot,
    output a_is_allzero
);

    onehot_2bit u0_onehot_2bit(
        .a(a[3:2]),
        .a_is_onehot(a_is_onehot_0),
        .a_is_allzero(a_is_allzero_0),
    );

    onehot_2bit u1_onehot_2bit(
        .a(a[1:0]),
        .a_is_onehot(a_is_onehot_1),
        .a_is_allzero(a_is_allzero_1),
    );

    assign a_is_onehot = (a_is_onehot_0 && a_is_allzero_1) ||  (a_is_allzero_0 && a_is_onehot_1) |;
    assign a_is_allzero = a_is_allzero_0 && a_is_allzero_1;

endmodule


module onehot_8bit  (
) (
    input [7:0] a,
    output a_is_onehot,
    output a_is_allzero
);

    onehot_4bit u0_onehot_4bit(
        .a(a[7:4]),
        .a_is_onehot(a_is_onehot_0),
        .a_is_allzero(a_is_allzero_0),
    );

    onehot_4bit u1_onehot_4bit(
        .a(a[3:0]),
        .a_is_onehot(a_is_onehot_1),
        .a_is_allzero(a_is_allzero_1),
    );

    assign a_is_onehot = (a_is_onehot_0 && a_is_allzero_1) ||  (a_is_allzero_0 && a_is_onehot_1) |;
    assign a_is_allzero = a_is_allzero_0 && a_is_allzero_1;

endmodule
