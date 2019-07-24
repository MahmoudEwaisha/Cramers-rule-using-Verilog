# Implementation of Cramer's rule method using Verilog

This project is purely educational. It is an implementation of system of linear equations solver using Verilog hardware description language. Simulation was done using ModelSim.

The project consists of 2 files; the main verilog file, and a testbench written in SystemVerilog. The full implementation details can be found in the "ReadMe.pdf" file. 

If you want to test the files, input your matrix in the input.txt as follows.

If you have a system of equations like 6x + y = 2 and 3x – 2y = -1

Then write in the input file "input.txt":


6 1 2


3 -2 -1

And the same way goes for any number of equations.

Next open “Cramer_main.v”, and change the parameter “size” in line 6 to the size of your input coefficient matrix, that is, if like in the example above you have 2 equations with 2 unknowns, then set the size parameter to 2. If you have 3 equations with 3 unknowns, then set it to 3 and so on.
The other parameter “test” in line 7 is used to indicate if you are running the main module, or running the testbench (this is explained in the attached PDF). So, if you want to write your own matrix in the input file and run the cramer module, then keep this test parameter = 0, and if you want to run the testbench, then set this parameter to 1 first then run the testbench.

After simulating, you should find the results in the "output.txt" file.