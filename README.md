# RTL Synthesis of 16-bit ALU using Yosys
The 16-bit Arithmetic Logic Unit (ALU) is a fundamental digital circuit designed to perform arithmetic and logic operations on 16-bit binary numbers. It consists of various functional blocks, such as adders, logic gates, and multiplexers, integrated to execute a wide range of operations like addition, subtraction, AND, OR, XOR, and more. The design is implemented using the Verilog hardware description language and subjected to RTL simulation and synthesis using Yosys, an open-source synthesis tool.

## RTL Simulation of ALU
First we need to write the Verilog code for ALU design and then provide it with a proper stimulus. 
### A sample Verilog code for 16-bit ALU 

```
module ALU_16bit (
    input [15:0] operand_A,
    input [15:0] operand_B,
    input [2:0] operation,
    output reg [15:0] result,
    output reg zero_flag
);

    always @(*) begin
        case(operation)
            3'b000: result = operand_A + operand_B; // Addition
            // Add more cases for other operations
            // ...
            default: result = 16'b0; // Default case for unsupported operation
        endcase

    end

endmodule

```

Now, we have to provide a proper stimulus to the design in order to check its functionality.
### A Testbench snippet for the design

```
module ALU_16bit_TB;

    // Declare signals for testbench
    reg [15:0] operand_A;
    reg [15:0] operand_B;
    reg [2:0] operation;
    wire [15:0] result;
    wire zero_flag;

    // Instantiate the ALU module
    ALU_16bit uut (
        .operand_A(operand_A),
        .operand_B(operand_B),
        .operation(operation),
        .result(result),
        .zero_flag(zero_flag)
    );

    // Initialize testbench inputs
    initial begin
        operand_A = 16'd45;
        operand_B = 16'd18;
        operation = 3'b000; // Addition
        #10; // Wait for a few time units

        // Display results
        $display("Operand A: %b", operand_A);
        $display("Operand B: %b", operand_B);
        $display("Operation: %b", operation);
        $display("Result: %b", result);
        $display("Zero Flag: %b", zero_flag);
        
        // Add more test cases as needed

        $finish; // End simulation
    end

endmodule

```
Use the respective `$dumpfile` and `$dumpvars` for dumping all the generated values in a proper file. Once the files are created we are good to go for simulation. Open the terminal in the proper directory (where both the design and testbench files are present). 
Use the command `iverilog design_file.v testbench_file.v` to compile and simulate both the design and testbench files. Once this is done an "a.out" file is created and can be verified by typing `ls` command.
Now, we have to run the a.out file using `./a.out` command. Once this is done, a vcd (value change dump) file which will be used to generate waveforms is created. To generate a waveform use 
`gtkwave file_name.vcd` command in the terminal. 

The below image shows the waveform generaed after the simulation: 
