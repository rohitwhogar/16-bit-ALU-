# RTL Synthesis of 16-bit ALU using Yosys
The 16-bit Arithmetic Logic Unit (ALU) is a fundamental digital circuit designed to perform arithmetic and logic operations on 16-bit binary numbers. It consists of various functional blocks, such as adders, logic gates, and multiplexers, integrated to execute a wide range of operations like addition, subtraction, AND, OR, XOR, and more. The design is implemented using the Verilog hardware description language and subjected to RTL simulation and synthesis using Yosys, an open-source synthesis tool. A basic block diagram of an ALU is shown below:

Key features and functions of an ALU include:

1. Arithmetic Operations: ALUs can perform basic arithmetic operations, such as addition, subtraction, multiplication, and division, on binary numbers. These operations are fundamental to various computations in digital systems.

2. Logic Operations: In addition to arithmetic operations, ALUs also handle logic operations, including bitwise AND, OR, XOR (exclusive OR), and NOT. These operations are crucial for making decisions and evaluating conditions in programs and circuits.

3. Bit Manipulation: ALUs can manipulate individual bits of data, shifting them left or right, and rotating them. These operations are useful for tasks like data packing, unpacking, and addressing.

4. Comparison: ALUs can compare two binary numbers and determine their relationship, such as checking for equality, greater than, less than, etc. These comparisons are essential for decision-making in programming and circuit control.

5. Conditional Operations: ALUs often support conditional operations, where the result of one operation depends on the outcome of a previous comparison or logic operation. This is vital for implementing branching and conditional execution in programs.

6. Width and Precision: The width of an ALU refers to the number of bits it can process in parallel, which affects the range and precision of the arithmetic operations it can perform. Modern ALUs typically operate on 32-bit or 64-bit data.

7. Pipeline Processing: In modern CPUs, ALUs are often designed to work in parallel and can be part of a pipeline where multiple instructions are processed concurrently, improving overall throughput.

8. Control Logic: The ALU is controlled by control signals that dictate the type of operation to perform, the sources of data, and where to store the result. These signals are usually generated by the CPU's control unit.
   
### Basic Block diagram of an ALU

![ALU](https://github.com/rohitwhogar/16-bit-ALU-/assets/72391479/b2adaf32-cb48-48dd-9f52-aaf42047367c)

Below is the sample 8-bit ALU representation involving combinational and sequential circuits. 

![ALU_2](https://github.com/rohitwhogar/16-bit-ALU-/assets/72391479/92ce427c-94ec-492a-b9fd-41d6a8909ad3)


## RTL Simulation of 16-bit ALU
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
Use the respective `$dumpfile` and `$dumpvars` for dumping all the generated values in a proper file. 

## Yosys: *Where Verilog Dreams Transform into Silicon Reality!*
In this project, we will be using an open-source software called Yosys for simulation and synthesis. Yosys is an open-source software framework used for Verilog RTL synthesis, formal verification, and various other digital design tasks. It is widely employed in the field of electronic design automation (EDA) to convert high-level hardware descriptions written in the Verilog hardware description language (HDL) into lower-level representations suitable for hardware implementation. Yosys offers a range of synthesis and optimization tools that help designers create efficient digital circuits.

For more info visit [YosysHQ](https://github.com/YosysHQ/yosys)

Now lets carry on with the implementation part. So once the files are created we are good to go for simulation!!!

Open the terminal in the proper directory (where both the design and testbench files are present). So in our case the directory will be `~/synthosphere/testfiles/`.

Use the command `iverilog design_file.v testbench_file.v` to compile and simulate both the design and testbench files. Once this is done an "a.out" file is created and can be verified by typing `ls` command.

Now, we have to run the a.out file using `./a.out` command. Once this is done, a vcd (value change dump) file which will be used to generate waveforms is created. 

To generate a waveform use `gtkwave file_name.vcd` command in the terminal. 

##### The below image shows the monitored results corresponding to the given stimulus:

![monitored_results](https://github.com/rohitwhogar/16-bit-ALU-/assets/72391479/f5690db9-6c37-4077-a15f-ad013844300a)

The below image shows the waveform generaed after the simulation:
##### Pre-synthesis Waveform  

![waveform_pre_synthesis](https://github.com/rohitwhogar/16-bit-ALU-/assets/72391479/2ddbcba7-9eed-47bb-a487-9976c1afc337)

The waveform suggests the output values being displayed for the respective inputs and respective operations(ADD,Subtract,etc). Below is the Block diagram generated by the tool before synthesis.
So to generate a block diagram use `show top_module_name` in the terminal. 

![Block_diagram_pre_synthesis](https://github.com/rohitwhogar/16-bit-ALU-/assets/72391479/7ff51522-11b3-4825-a841-e308afe1b049)

## RTL Synthesis of 16-bit ALU
##### Now its time to perform Synthesis!!!

For performing synthesis we have to open yosys, to do so use the command `yosys`. 
Now we are inside yosys and ready to perform synthesis for our design. 
Before this we have to specify the library and this can be done by using the command `read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80` 
After this, the verilog file has to be read by the tool in order to perform synthesis, use `read_verilog file_name.v` to do so.

Once this is done we are good to go for synthesis!!! Use `synth -top top_module_name` to perform synthesis. Now the tool will perform synthesis and generates a netlist which contains the information about the gates and flip-flops used in the design. 

The below image shows the netlist generated in case of 16-bit ALU.
##### Statistics 
![statistics](https://github.com/rohitwhogar/16-bit-ALU-/assets/72391479/976a3709-4eb3-4398-86d7-e766189117de)

Once this is done, its necessary to map the gates and flip-flops to their technology library.
 ##### Use `dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80` for Sequential circuits.
 ##### Use `abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80` for combinational circuits.

Even in our case, the 16-bit ALU is mapped to its respective technology library. The below images show the report of sequential and combinational ciruits being mapped to their technology libraries.

##### Report of Sequential mapping:
![D-FFs_mapping](https://github.com/rohitwhogar/16-bit-ALU-/assets/72391479/c0df901d-0f51-4fee-b915-22db1bc3655f)

##### Report of Combinational mapping:
![modules_1](https://github.com/rohitwhogar/16-bit-ALU-/assets/72391479/614d7c92-4cb0-4750-b013-1c52fee90300)
![modules_2](https://github.com/rohitwhogar/16-bit-ALU-/assets/72391479/5d700d02-ec01-4ef7-8789-f3766bc61c47)

Now to see the block diagram generated after synthesis use `show alu` command. 
#### Note: The Block was not generated due to high instance count. The system was not compatible in terms of RAM to generate the post-synthesis block.I apologise for not being able to generate the findings.

After this the next step is to write the generated netlist to a file. To do so,
##### Use `write_verilog any_file_name.v` - This provides a netlist with the comments and redundancies!!
So in order to avoid comments,
##### Use `write_verilog -noattr any_file_name.v` - This provides a clean netlist with no attributes!!
Check the `output_files` folder in this repo to see the netlist generated.
Since the netlist files are generated, exit from yosys. Use `exit` to do so.

#### ***Synthesis Done!!!***

Now to verify the functionality of the design after synthesis, perform the following steps:
 
1. To generate an "a.out file" use `iverilog netlist_file_name.v ../verilog_model/primitives.v ../verilog_model/sky130_fd_sc_hd_edited.v testbench_file_name.v` 

2. To generate a vcd file use `./a.out` 

3. To view the waveform use `gtkwave file_name.vcd` 

After this, check the waveform and verify the results with the one generated before synthesis. If both the waveform matches then the design is perfectly synthesised and the functionality is met.

The below image shows the waveform generated after synthesis. 

 ##### Post synthesis Waveform
 
 ![waveform_post_synthesis](https://github.com/rohitwhogar/16-bit-ALU-/assets/72391479/26c26bdb-2485-4bfc-8e73-820844f388d8)

This shows that the functionality is met and it remains intact after synthesis by providing the desired results.

## Conclusion
Thus, the provided Verilog code for a 16-bit ALU, along with its corresponding testbench, demonstrates a functional design capable of performing arithmetic and logic operations on 16-bit operands. The code utilizes case statements to efficiently manage different operations. After synthesis using Yosys, the design undergoes logic optimization and technology mapping, resulting in a hardware representation that can be targeted to specific FPGA or ASIC technologies. By following the provided steps and guidelines, one can confidently verify that the functionality of the 16-bit ALU is successfully met post-synthesis in Yosys, confirming its correct operation in real hardware scenarios.
