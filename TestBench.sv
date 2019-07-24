
module testbench;
	reg st;
	reg signed [31:0] m [0:2][0:2];
	reg signed [31:0] r [0:2];
	integer i, j, data_file, out_file, scan_file, garbage;
	reg signed [31:0] ans [0:2][0:2];
	cramer mod1(st);

initial begin
											/*_________Test Case 1 _________*/
	
	m[0][0] = 1; m[0][1] = 2; m[0][2] = -1; r[0] = 5;
	m[1][0] = 2; m[1][1] = -1; m[1][2] = 1; r[1] = 1;
	m[2][0] = 3; m[2][1] = 3; m[2][2] = -2; r[2] = 8;
	st = 0;
	data_file = $fopen("input.txt", "w");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3+1; j=j+1) begin
			if (j==3) $fwrite(data_file, "%0d\n", r[i]);
			else $fwrite(data_file, "%0d ", m[i][j]); 
		end
	end
	$fclose(data_file);
	#100; st = 1; #100; st = 0;
	
	out_file = $fopen("output.txt", "r");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3; j=j+1) begin
			if (j==1) scan_file = $fscanf(out_file,"%c\n", garbage);
			else scan_file = $fscanf(out_file,"%d\n", ans[i][j]);
		end
	end
	$fclose(out_file); 
	$display("x1= %0d.%0d", ans[0][0], ans[0][2]);
	$display("x2= %0d.%0d", ans[1][0], ans[1][2]);
	$display("x3= %0d.%0d", ans[2][0], ans[2][2]);

										/* __ASSERT__ */
	assert(ans[0][0]==1 && ans[0][2]==0) else $error("Test Case 1 wrong value");
	assert(ans[1][0]==3 && ans[1][2]==0) else $error("Test Case 1 wrong value");
	assert(ans[2][0]==2 && ans[2][2]==0) else $error("Test Case 1 wrong value");

	
												/*_________Test Case 2 & 4 _________*/
	m[0][0] = 1; m[0][1] = 0; m[0][2] = 1; r[0] = 1;
	m[1][0] = 0; m[1][1] = 1; m[1][2] = 1; r[1] = 1;
	m[2][0] = 1; m[2][1] = 1; m[2][2] = 0;  r[2] = 4;
	st = 0;
	
	data_file = $fopen("input.txt", "w");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3+1; j=j+1) begin
			if (j==3) $fwrite(data_file, "%0d\n", r[i]);
			else $fwrite(data_file, "%0d ", m[i][j]); 
		end
	end
	$fclose(data_file);
	#100; st = 1; #100; st=0;

	out_file = $fopen("output.txt", "r");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3; j=j+1) begin
			if (j==1) scan_file = $fscanf(out_file, "%c\n", garbage);
			else scan_file = $fscanf(out_file, "%d\n", ans[i][j]);
		end
	end
	$fclose(out_file);
	$display("x1= %0d.%0d", ans[0][0], ans[0][2]);
	$display("x2= %0d.%0d", ans[1][0], ans[1][2]);
	$display("x3= %0d.%0d", ans[2][0], ans[2][2]);

								/* __ASSERT__ */
	assert(ans[0][0]==2 && ans[0][2]==0) else $error("Test Case 2&4 wrong value");
	assert(ans[1][0]==2 && ans[1][2]==0) else $error("Test Case 2&4 wrong value");
	assert(ans[2][0]==-1 && ans[2][2]==0) else $error("Test Case 2&4 wrong value");

										/*_________Test Case 3 _________*/
	
	m[0][0] = 3; m[0][1] = 1; m[0][2] = 1; r[0] = 3;
	m[1][0] = 2; m[1][1] = 2; m[1][2] = 5; r[1] = -1;
	m[2][0] = 1; m[2][1] = -3; m[2][2] = -4; r[2] = 2;
	st = 0;
	
	data_file = $fopen("input.txt", "w");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3+1; j=j+1) begin
			if (j==3) $fwrite(data_file, "%0d\n", r[i]);
			else $fwrite(data_file, "%0d ", m[i][j]); 
		end
	end
	$fclose(data_file);
	#100; st = 1; #100; st = 0;
	
	out_file = $fopen("output.txt", "r");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3; j=j+1) begin
			if (j==1) scan_file = $fscanf(out_file,"%c\n", garbage);
			else scan_file = $fscanf(out_file,"%d\n", ans[i][j]);
		end
	end
	$fclose(out_file);
	$display("x1= %0d.%0d", ans[0][0], ans[0][2]);
	$display("x2= %0d.%0d", ans[1][0], ans[1][2]);
	$display("x3= %0d.%0d", ans[2][0], ans[2][2]);

								/* __ASSERT__ */
	assert(ans[0][0]==1 && ans[0][2]==0) else $error("Test Case 3 wrong value");
	assert(ans[1][0]==1 && ans[1][2]==0) else $error("Test Case 3 wrong value");
	assert(ans[2][0]==-1 && ans[2][2]==0) else $error("Test Case 3 wrong value");

										/*_________Test Case 5 _________*/
	
	m[0][0] = 3; m[0][1] = 2; m[0][2] = 1; r[0] = 20;
	m[1][0] = 4; m[1][1] = 0; m[1][2] = -10; r[1] = -10;
	m[2][0] = -1; m[2][1] = -2; m[2][2] = 2; r[2] = 1;
	st = 0;
	
	data_file = $fopen("input.txt", "w");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3+1; j=j+1) begin
			if (j==3) $fwrite(data_file, "%0d\n", r[i]);
			else $fwrite(data_file, "%0d ", m[i][j]); 
		end
	end
	$fclose(data_file);
	#100; st = 1; #100; st = 0;
	
	out_file = $fopen("output.txt", "r");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3; j=j+1) begin
			if (j==1) scan_file = $fscanf(out_file,"%c\n", garbage);
			else scan_file = $fscanf(out_file,"%d\n", ans[i][j]);
		end
	end
	$fclose(out_file);
	$display("x1= %0d.%0d", ans[0][0], ans[0][2]);
	$display("x2= %0d.0%0d", ans[1][0], ans[1][2]);
	$display("x3= %0d.%0d", ans[2][0], ans[2][2]);

								/* __ASSERT__ */
	assert(ans[0][0]==5 && ans[0][2]==6250) else $error("Test Case 5 wrong value");
	assert(ans[1][0]==0 && ans[1][2]==0625) else $error("Test Case 5 wrong value");
	assert(ans[2][0]==3 && ans[2][2]==2500) else $error("Test Case 5 wrong value");

										/*_________Test Case 6 _________*/
	
	m[0][0] = 4; m[0][1] = -1; m[0][2] = 3; r[0] = 2;
	m[1][0] = 1; m[1][1] = 5; m[1][2] = -2; r[1] = 3;
	m[2][0] = 3; m[2][1] = 2; m[2][2] = 4; r[2] = 6;
	st = 0;
	
	data_file = $fopen("input.txt", "w");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3+1; j=j+1) begin
			if (j==3) $fwrite(data_file, "%0d\n", r[i]);
			else $fwrite(data_file, "%0d ", m[i][j]); 
		end
	end
	$fclose(data_file);
	#100; st = 1; #100; st = 0;
	
	out_file = $fopen("output.txt", "r");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3; j=j+1) begin
			if (j==1) scan_file = $fscanf(out_file,"%c\n", garbage);
			else scan_file = $fscanf(out_file,"%d\n", ans[i][j]);
		end
	end
	$fclose(out_file);
	$display("x1= %0d.%0d", ans[0][0], ans[0][2]);
	$display("x2= %0d.%0d", ans[1][0], ans[1][2]);
	$display("x3= %0d.%0d", ans[2][0], ans[2][2]);

								/* __ASSERT__ */
	assert(ans[0][0]==0 && ans[0][2]==0) else $error("Test Case 6 wrong value");
	assert(ans[1][0]==1 && ans[1][2]==0) else $error("Test Case 6 wrong value");
	assert(ans[2][0]==1 && ans[2][2]==0) else $error("Test Case 6 wrong value");

										/*_________Test Case 7 _________*/
	
	m[0][0] = 1; m[0][1] = 1; m[0][2] = 1; r[0] = 1;
	m[1][0] = 1; m[1][1] = 1; m[1][2] = 1; r[1] = 2;
	m[2][0] = 1; m[2][1] = 1; m[2][2] = 1; r[2] = 3;
	st = 0;
	
	data_file = $fopen("input.txt", "w");
	for (i=0; i<3; i=i+1) begin
		for (j=0; j<3+1; j=j+1) begin
			if (j==3) $fwrite(data_file, "%0d\n", r[i]);
			else $fwrite(data_file, "%0d ", m[i][j]); 
		end
	end
	$fclose(data_file);
	#100; st = 1; #100; st = 0;
	
	out_file = $fopen("output.txt", "r");
	scan_file = $fscanf(out_file,"%c\n", ans[0][0]);
	$fclose(out_file);
	$display("%c", ans[0][0]);

								/* __ASSERT__ */
	assert(ans[0][0] == "x") else $error("Test Case 7 wrong value");

end
endmodule
