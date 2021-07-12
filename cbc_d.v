`timescale 1ns / 1ps

module cbc_d(planetext, image, key, iv);
output reg [128:1] planetext;
input [128:1] image;
input[128:1] key;
input [128:1] iv;
reg [32:1] w[1:44];
reg [32:1] s[1:4];
reg[127:0] a;

wire [32:1] w1 ,w2 ,w3 ,w4 ,w5 ,w6 ,w7 ,w8 ,w9 ,w10 ,w11 ,w12 ,w13 ,w14 ,w15 ,w16 ,w17 ,w18 ,w19 ,w20 ,w21 ,w22 ,w23 ,w24 ,w25 ,w26 ,w27 ,w28 ,w29 ,w30 ,w31 ,w32 ,w33 ,w34 ,w35 ,w36 ,w37 ,w38 ,w39 ,w40 ,w41 ,w42 ,w43,w44;
integer i;
integer j;
reg [8:1] temp1, temp2, temp3, temp4;
processkey p(w1 ,w2 ,w3 ,w4 ,w5 ,w6 ,w7 ,w8 ,w9 ,w10 ,w11 ,w12 ,w13 ,w14 ,w15 ,w16 ,w17 ,w18 ,w19 ,w20 ,w21 ,w22 ,w23 ,w24 ,w25 ,w26 ,w27 ,w28 ,w29 ,w30 ,w31 ,w32 ,w33 ,w34 ,w35 ,w36 ,w37 ,w38 ,w39 ,w40 ,w41 ,w42 ,w43 , w44,key);
//reg [8:1] k=8'h2b; 


function [8:1] substitute(input [8:1] sb);
	reg [0:127] sbox[0:15];
	
	begin
		sbox[0] =128'h52096AD53036A538BF40A39E81F3D7FB;
		sbox[1] =128'h7CE339829B2FFF87348E4344C4DEE9CB;
		sbox[2] =128'h547B9432A6C2233DEE4C950B42FAC34E;
		sbox[3] =128'h082EA16628D924B2765BA2496D8BD125;
		sbox[4] =128'h72F8F66486689816D4A45CCC5D65B692;
		sbox[5] =128'h6C704850FDEDB9DA5E154657A78D9D84;
		sbox[6] =128'h90D8AB008CBCD30AF7E45805B8B34506;
		sbox[7] =128'hD02C1E8FCA3F0F02C1AFBD0301138A6B;
		sbox[8] =128'h3A9111414F67DCEA97F2CFCEF0B4E673;
		sbox[9] =128'h96AC7422E7AD3585E2F937E81C75DF6E;
		sbox[10]=128'h47F11A711D29C5896FB7620EAA18BE1B;
		sbox[11]=128'hFC563E4BC6D279209ADBC0FE78CD5AF4;
		sbox[12]=128'h1FDDA8338807C731B11210592780EC5F;
		sbox[13]=128'h60517FA919B54A0D2DE57A9F93C99CEF;
		sbox[14]=128'hA0E03B4DAE2AF5B0C8EBBB3C83539961;
		sbox[15]=128'h172B047EBA77D626E169146355210C7D;
		
		substitute = sbox[sb[8:5]][8*sb[4:1] +:8];
	end
endfunction 

//automatic function can be recursive 
function automatic [7 : 0] gm2(input [7 : 0] op);
 begin
	gm2 = {op[6 : 0], 1'b0} ^ (8'h1b & {8{op[7]}});
 end
endfunction // gm2

function [7 : 0] gm3(input [7 : 0] op);
 begin
	gm3 = gm2(op) ^ op;
 end
endfunction // gm3

function [7 : 0] gm4(input [7 : 0] op);
 begin
	gm4 = gm2(gm2(op));
 end
endfunction // gm4

function [7 : 0] gm8(input [7 : 0] op);
 begin
	gm8 = gm2(gm4(op));
 end
endfunction // gm8

function [7 : 0] gm09(input [7 : 0] op);
 begin
	gm09 = gm8(op) ^ op;
 end
endfunction // gm09

function [7 : 0] gm11(input [7 : 0] op);
 begin
	gm11 = gm8(op) ^ gm2(op) ^ op;
 end
endfunction // gm11

function [7 : 0] gm13(input [7 : 0] op);
 begin
	gm13 = gm8(op) ^ gm4(op) ^ op;
 end
endfunction // gm13

function [7 : 0] gm14(input [7 : 0] op);
 begin
	gm14 = gm8(op) ^ gm4(op) ^ gm2(op);
 end
endfunction // gm14

function [31 : 0] inv_mixw(input [31 : 0] wa);
 reg [7 : 0] b0, b1, b2, b3;
 reg [7 : 0] mb0, mb1, mb2, mb3;
 begin
	b0 = wa[31 : 24];
	b1 = wa[23 : 16];
	b2 = wa[15 : 08];
	b3 = wa[07 : 00];

	mb0 = gm14(b0) ^ gm11(b1) ^ gm13(b2) ^ gm09(b3);
	mb1 = gm09(b0) ^ gm14(b1) ^ gm11(b2) ^ gm13(b3);
	mb2 = gm13(b0) ^ gm09(b1) ^ gm14(b2) ^ gm11(b3);
	mb3 = gm11(b0) ^ gm13(b1) ^ gm09(b2) ^ gm14(b3);

	inv_mixw = {mb0, mb1, mb2, mb3};
 end
endfunction // mixw

function [127 : 0] inv_mixcolumns(input [127 : 0] data);
 reg [31 : 0] wa0, wa1, wa2, wa3;
 reg [31 : 0] ws0, ws1, ws2, ws3;
 begin
	wa0 = data[127 : 096];
	wa1 = data[095 : 064];
	wa2 = data[063 : 032];
	wa3 = data[031 : 000];

	ws0 = inv_mixw(wa0);
	ws1 = inv_mixw(wa1);
	ws2 = inv_mixw(wa2);
	ws3 = inv_mixw(wa3);

	inv_mixcolumns = {ws0, ws1, ws2, ws3};
 end
endfunction // inv_mixcolumns


always @(*)
  begin
	w[1]= w1; w[2]= w2; w[3]= w3; w[4]= w4; w[5]= w5; w[6]= w6; w[7]= w7; w[8]= w8; w[9]= w9; w[10]= w10; w[11]= w11; w[12]= w12; w[13]= w13; w[14]= w14; w[15]= w15; w[16]= w16; w[17]= w17; w[18]= w18; w[19]= w19; w[20]= w20; w[21]= w21; w[22]= w22; w[23]= w23; w[24]= w24; w[25]= w25; w[26]= w26; w[27]= w27; w[28]= w28; w[29]= w29; w[30]= w30; w[31]= w31; w[32]= w32; w[33]= w33; w[34]= w34; w[35]= w35; w[36]= w36; w[37]= w37; w[38]= w38; w[39]= w39; w[40]= w40; w[41]= w41; w[42]= w42; w[43]= w43; w[44]= w44;

	s[1]=image[128:97];
	s[2]=image[96:65];
	s[3]=image[64:33];
	s[4]=image[32:1];
	//initial transformation
	s[1]=s[1]^w41;
	s[2]=s[2]^w42;
	s[3]=s[3]^w43;
	s[4]=s[4]^w44;
	//round 1 to 9
	for(i=1;i<=9;i=i+1)
	begin
	
		//shift rows
		temp1=s[4][24:17];
		s[4][24:17]=s[3][24:17];
		s[3][24:17]=s[2][24:17];
		s[2][24:17]=s[1][24:17];
		s[1][24:17]=temp1;
		
		temp1=s[4][16:9];
		temp2=s[3][16:9];
		s[4][16:9]=s[2][16:9];
		s[3][16:9]=s[1][16:9];
		s[2][16:9]=temp1;
		s[1][16:9]=temp2;
		
		temp1=s[1][8:1];
		s[1][8:1]=s[2][8:1];
		s[2][8:1]=s[3][8:1];
		s[3][8:1]=s[4][8:1];
		s[4][8:1]=temp1;
		
		
		//substitute bytes
		for(j=1;j<=4;j=j+1)
		begin
			s[j][32:25]=substitute(s[j][32:25]);
			s[j][24:17]=substitute(s[j][24:17]);
			s[j][16:9]=substitute(s[j][16:9]);
			s[j][8:1]=substitute(s[j][8:1]);
		end
		
		
		//add round key
		s[1]=s[1]^w[40-(4*i)+1];
		s[2]=s[2]^w[40-(4*i)+2];
		s[3]=s[3]^w[40-(4*i)+3];
		s[4]=s[4]^w[40-(4*i)+4];
		
		
		
		//mix columns
		/*s[1]=32'h473794ed;
		s[2]=32'h40d4e4a5;
		s[3]=32'ha3703aa6;
		s[4]=32'h4c9f42bc;*/
		
		a={s[1],s[2],s[3],s[4]};
		{s[1],s[2],s[3],s[4]}=inv_mixcolumns(a);
		
		
		
	end
	
	//round 10
	
	//shift rows
	temp1=s[4][24:17];
	s[4][24:17]=s[3][24:17];
	s[3][24:17]=s[2][24:17];
	s[2][24:17]=s[1][24:17];
	s[1][24:17]=temp1;
	
	temp1=s[4][16:9];
	temp2=s[3][16:9];
	s[4][16:9]=s[2][16:9];
	s[3][16:9]=s[1][16:9];
	s[2][16:9]=temp1;
	s[1][16:9]=temp2;
	
	temp1=s[1][8:1];
	s[1][8:1]=s[2][8:1];
	s[2][8:1]=s[3][8:1];
	s[3][8:1]=s[4][8:1];
	s[4][8:1]=temp1;
	
	//substitute bytes
	for(j=1;j<=4;j=j+1)
	begin
		s[j][32:25]=substitute(s[j][32:25]);
		s[j][24:17]=substitute(s[j][24:17]);
		s[j][16:9]=substitute(s[j][16:9]);
		s[j][8:1]=substitute(s[j][8:1]);
	end
	
	//add round key
	s[1]=s[1]^w[1];
	s[2]=s[2]^w[2];
	s[3]=s[3]^w[3];
	s[4]=s[4]^w[4];
	
	
	
	
	planetext =  iv^{s[1],s[2],s[3],s[4]};
	
  end
endmodule
