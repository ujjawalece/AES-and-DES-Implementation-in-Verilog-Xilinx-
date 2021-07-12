`timescale 1ns / 1ps

module test;

	// Outputs
	wire [128:1] planetext;
	reg [128:1] image;
	reg [128:1] img[1:65536];
	reg [128:1] key;
	reg [128:1] iv;
	integer i;
	integer f;

	// Instantiate the Unit Under Test (UUT)
	cbc_d uut (planetext,image,key,iv);

	initial 
	begin

		#10 $readmemb("cbc_enc.txt",img);
		$display("f=%h",img[1]);
		f=$fopen("cbc_dec.txt","w");
		iv = 128'h04C723C31896059A071280E2EB27B275;
		#10
		for(i=1;i<=65536;i=i+1)
		 begin
			  image=img[i];
			  //$display("%h",image);
			  key = 128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
			  //$monitor("%d",i);  
			  //$display("%h",key);
			  $display("%h",planetext);
			  $fwrite(f,"%b\n",planetext);
			  #10 iv=image;
		 end 
		#10 $fclose(f);

	end
      
endmodule

