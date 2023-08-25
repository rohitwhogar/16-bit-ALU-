# RTL Synthesis of 16-bit ALU using Yosys
The 16-bit Arithmetic Logic Unit (ALU) is a fundamental digital circuit designed to perform arithmetic and logic operations on 16-bit binary numbers. It consists of various functional blocks, such as adders, logic gates, and multiplexers, integrated to execute a wide range of operations like addition, subtraction, AND, OR, XOR, and more. The design is implemented using the Verilog hardware description language and subjected to RTL simulation and synthesis using Yosys, an open-source synthesis tool.

##RTL Simulation of ALU
First we need to write the Verilog code for ALU design and then provide it with a proper stimulus. 
###Verilog code for 16-bit ALU 
```
module alu(a,b,sel,clk,reset,q);

input [15:0]a,b;
input clk,reset;
input [2:0]sel;
output reg [15:0]q;

always @(posedge clk)

begin

if(reset)
	q <= 0;
else
	case(sel)
	3'b000: q <= a+b;
	3'b001: q <= a-b;
	3'b010: q <= a*b;
	3'b011: q <= a%b;
	3'b100: q <= a&b;
	3'b101: q <= a|b;
	3'b110: q <= a^b;
	3'b111: q <= a&&b;
	default: q <= 8'bXXXXXXXX;
	endcase
	
end

endmodule
```

Now, we have to provide a proper stimulus to the design in order to check its functionality.
###Testbench for the design
```
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
```

