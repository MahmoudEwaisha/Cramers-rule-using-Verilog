
module cramer(start);

input start;

parameter size = 3;	// defines the size of the input square matrix
parameter test = 0;	//	used by the testbench

reg signed [31:0] m [0:size-1][0:size-1]; 	// base square matrix read from the input file
reg signed [31:0] z [0:size-1][0:size-1]; 	// to store temporary matrices to compute their determinants
reg signed [31:0] r [0:size-1];		// stores the vector
reg signed [32*size*size-1:0] oneDarray;	// stores 1d array of bits to be able to use it as input to the function
reg [31:0] ans [0:3]; // stores the digits of the final results of the equations unknowns
	
integer a, b, q, remainder; // variables used in calculating floating point division
integer i, j, k, g, x, y, data_file, scan_file, out_file;	// variables u	sed in for loops and file operations
integer signed determinant;	// stores the determinant of the base matrix

/*---------------------------------------------------------- Function Start ---------------------------------------------------------------*/
function automatic integer signed det;
	input integer n;
	input signed [32*size*size-1:0] input_array_1d;
	integer i, j, k, x, y, z, e, r;
	integer signed out, temp;
	reg signed [31:0] array_2d [0:size-1][0:size-1];
	reg signed [31:0] temp_2d [0:size-1][0:size-1];
	reg signed [32*size*size-1:0] temp_1d;
	
	begin
		out = 0;
		/*___________Reconstruct the 2d array of ints for calculation__________*/
		z = 0;
		for (i=0; i<n; i=i+1) begin
			for (j=0; j<n; j=j+1) begin
				array_2d[i][j] = input_array_1d[z*32+31 -: 32];
				z = z+1;
			end
		end

		/*________________________Compute the Determinant_______________________*/
    	if (n == 2) begin 
			out = (array_2d[0][0] * array_2d[1][1]) - (array_2d[0][1] * array_2d[1][0]);
			det = out;
		end
		else begin
			temp = 0;
			for (i=0; i<n; i=i+1) begin
				x=0;
				for (j=1; j<n; j=j+1) begin
					y=0;
					for (k=0; k<n; k=k+1) begin
						if (k != i) begin
							temp_2d[x][y] = array_2d[j][k];
							y=y+1;
						end
					end
				x=x+1;
				end

			/*_________________________Flatten the 2d array_______________________*/
			z=0;
			for (e=0; e<(n-1); e=e+1) begin
				for (r=0; r<(n-1); r=r+1) begin
					if (temp_2d[e][r] < 0) temp_1d[z*32+31 -: 32] = temp_2d[e][r];
					else temp_1d[z*32+31 -: 32] = temp_2d[e][r];
					z = z+1;
				end
			end

			/*__________________Recursively call the det function_________________*/
			temp = det(n-1, temp_1d);
			out = out + (array_2d[0][i] * (-1**(i)) * temp);
			end // end for
		det = out;
    	end // end else
	end
endfunction
/*-----------------------------------------------------------Function End---------------------------------------------------------------*/


initial begin
	#1;
	for (i=0; i<size; i=i+1) begin
		for (j=0; j<size; j=j+1) begin
			z[i][j] = 0;
		end
	end
end


always @* begin
	if(test == 1) wait(start == 1);

	if (test == 0 || start == 1) begin
		data_file = $fopen("input.txt", "r");
		for (i=0; i<size; i=i+1) begin
			for (j=0; j<size+1; j=j+1) begin
				if (j==size) scan_file = $fscanf(data_file, "%d\n", r[i]);
				else scan_file = $fscanf(data_file, "%d\n", m[i][j]); 
			end
		end
	end
	$fclose(data_file);
	$display("Read Matrix %p", m);
	$display("Read RHS vector %p", r);
	
	/*________________Construct 1d array of bits from the input 2d array of 32-bit ints________________*/
	k = 0;
	for (i=0; i<size; i=i+1) begin
		for (j=0; j<size; j=j+1) begin
			if (m[i][j] < 0) oneDarray[k*32+31 -: 32] = m[i][j];
			else oneDarray[k*32+31 -: 32] = m[i][j];
			k = k+1;
		end
	end
	
	/*_______________________________Compute coefficient matrix determinant______________________________*/
	determinant = det(size, oneDarray);
	b = determinant;
	$display("Read Matrix determinant = %0d", determinant);
	
	out_file = $fopen("output.txt", "w");
	if (determinant == 0) $fwrite(out_file, "x");
	else begin
	/*_____________________Create intermediate matrices and compute their determinants____________________*/
	
	for (g=0; g<size; g=g+1) begin // create n matrices

		for (i=0; i<size; i=i+1) begin
			for (j=0; j<size; j=j+1) begin
				if (j == g) z[i][j] = r[i];
				else z[i][j] = m[i][j];
			end
		end
		k = 0;
		for (x=0; x<size; x=x+1) begin
			for (y=0; y<size; y=y+1) begin
				if (z[x][y] < 0) oneDarray[k*32+31 -: 32] = z[x][y];
				else oneDarray[k*32+31 -: 32] = z[x][y];
				k = k+1;
			end
		end
		a = det(size, oneDarray);
		$display("Intermediate Matrix %0d = %p", g, z);
		$display("Intermediate Matrix %0d determinant = %0d", g, a);

		
		/*______________________________________Floating point division______________________________________*/

		if (a[31] && b[31]) begin
			a = -a;
			b = -b;
		end
		else if (a[31] == 1'b1) begin
			a = -a;
			$fwrite(out_file, "-");
		end
		else if (b[31] == 1'b1) begin
			b = -b;
			$fwrite(out_file, "-");
		end
		q = a/b;
		remainder = a - (q*b);
		for (i=0; i<4; i=i+1) begin
			remainder = remainder*10;
			ans[i] = remainder/b;
			remainder = remainder - (ans[i]*b);
		end
		b = determinant;

		/*___________________________________Write results in the output file_________________________________*/
		$fwrite(out_file, "%0d . ", q);
		for (i=0; i<4; i=i+1) begin
			$fwrite(out_file, "%0d", ans[i]);
		end
		$fwrite(out_file, "\n");
	end
	$fclose(out_file);
	end // end else
end //end always
endmodule

