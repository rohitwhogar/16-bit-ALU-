module tb_alu();

reg [15:0]a;
reg [15:0]b;
reg clk,reset;
reg [2:0]sel;
wire [15:0]q;

alu uut( .a(a), .b(b), .sel(sel), .q(q), .clk(clk), .reset(reset) );

initial

clk = 1'b0;
always #10 clk = ~clk;

initial 
begin
reset = 1'b0;
a = 16'd23;b=16'd43;sel = 3'b000;#20
a = 16'd45;b=16'd4;sel = 3'b001;#20
a = 16'd33;b=16'd7;sel = 3'b010;#20
a = 16'd86;b=16'd6;sel = 3'b011;#20
a = 16'd44;b=16'd22;sel = 3'b100;#20
a = 16'd34;b=16'd12;sel = 3'b101;#20
a = 16'd67;b=16'd78;sel = 3'b110;#20
a = 16'd3;b=16'd7;sel = 3'b111;#20

reset = 1'b1;#40
$finish;
end

initial
begin
$monitor("q = %d", q);
$dumpfile("alu.vcd");
$dumpvars;

end

endmodule

