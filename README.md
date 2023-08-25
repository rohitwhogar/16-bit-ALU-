# RTL Synthesis of 16-bit ALU using Yosys
The 16-bit Arithmetic Logic Unit (ALU) is a fundamental digital circuit designed to perform arithmetic and logic operations on 16-bit binary numbers. It consists of various functional blocks, such as adders, logic gates, and multiplexers, integrated to execute a wide range of operations like addition, subtraction, AND, OR, XOR, and more. The design is implemented using the Verilog hardware description language and subjected to RTL simulation and synthesis using Yosys, an open-source synthesis tool.

## RTL Simulation of ALU
First we need to write the Verilog code for ALU design and then provide it with a proper stimulus. 
### Verilog code for 16-bit ALU 
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
### Testbench for the design
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
Once the files are created we are good to go for simulation. Open the terminal in the proper directory (where both the design and testbench files are present). 
Use the command `iverilog design_file.v testbench_file.v` to compile and simulate both the design and testbench files. Once this is done an a.out  file is created and can be verified by typing `ls` command.
Now, we have to run the a.out file using `./a.out` command. Once this is done, a vcd (value change dump) file which will be used to generate waveforms is created. To generate a waveform use `gtkwave file_name.vcd` command in the terminal. 

The below image shows the waveform generaed after the simulation: 
https://github.com/rohitwhogar/16-bit-ALU-/blob/c874427cb512412dac1721e20c6b38763d065cdb/images/waveform_pre_synthesis.png  
