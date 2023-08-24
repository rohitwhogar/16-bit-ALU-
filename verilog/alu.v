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
