`timescale 1ns / 1ps
module processkey(output reg[32:1] w1 ,w2 ,w3 ,w4 ,w5 ,w6 ,w7 ,w8 ,w9 ,w10 ,w11 ,w12 ,w13 ,w14 ,w15 ,w16 ,w17 ,w18 ,w19 ,w20 ,w21 ,w22 ,w23 ,w24 ,w25 ,w26 ,w27 ,w28 ,w29 ,w30 ,w31 ,w32 ,w33 ,w34 ,w35 ,w36 ,w37 ,w38 ,w39 ,w40 ,w41 ,w42 ,w43 , w44, input[128:1] key);
integer i;
reg [32:1] temp;
reg [8:1] temp1;
reg [32:1] w[1:44];
reg [8:1] rcon[1:10];

function [8:1] substitute(input [8:1] sb);
	reg [0:127] sbox[0:15];
	
	begin
		sbox[0] =128'h637C777BF26B6FC53001672BFED7AB76;
		sbox[1] =128'hCA82C97DFA5947F0ADD4A2AF9CA472C0;
		sbox[2] =128'hB7FD9326363FF7CC34A5E5F171D83115;
		sbox[3] =128'h04C723C31896059A071280E2EB27B275;
		sbox[4] =128'h09832C1A1B6E5AA0523BD6B329E32F84;
		sbox[5] =128'h53D100ED20FCB15B6ACBBE394A4C58CF;
		sbox[6] =128'hD0EFAAFB434D338545F9027F503C9FA8;
		sbox[7] =128'h51A3408F929D38F5BCB6DA2110FFF3D2;
		sbox[8] =128'hCD0C13EC5F974417C4A77E3D645D1973;
		sbox[9] =128'h60814FDC222A908846EEB814DE5E0BDB;
		sbox[10]=128'hE0323A0A4906245CC2D3AC629195E479;
		sbox[11]=128'hE7C8376D8DD54EA96C56F4EA657AAE08;
		sbox[12]=128'hBA78252E1CA6B4C6E8DD741F4BBD8B8A;
		sbox[13]=128'h703EB5664803F60E613557B986C11D9E;
		sbox[14]=128'hE1F8981169D98E949B1E87E9CE5528DF;
		sbox[15]=128'h8CA1890DBFE6426841992D0FB054BB16;
		
		substitute = sbox[sb[8:5]][8*sb[4:1] +:8];
	end
endfunction 



always@(*)
	begin
	rcon[1]=8'h01;
	rcon[2]=8'h02;
	rcon[3]=8'h04;
	rcon[4]=8'h08;
	rcon[5]=8'h10;
	rcon[6]=8'h20;
	rcon[7]=8'h40;
	rcon[8]=8'h80;
	rcon[9]=8'h1b;
	rcon[10]=8'h36;
	
	w1=key[128:97];
	w2=key[96:65];
	w3=key[64:33];
	w4=key[32:1];
	w[1]=w1; w[2]=w2; w[3]=w3; w[4]=w4;
	for(i=5; i<=44; i=i+1)
	begin
		temp = w[i-1];
		if(i%4 == 1)
		begin
			temp1=temp[32:25];
			temp[32:25]=temp[24:17];
			temp[24:17]=temp[16:9];
			temp[16:9]=temp[8:1];
			temp[8:1]=temp1;
			
			temp[32:25]=substitute(temp[32:25]);
			temp[24:17]=substitute(temp[24:17]);
			temp[16:9]=substitute(temp[16:9]);
			temp[8:1]=substitute(temp[8:1]);
			
			temp[32:25]= rcon[(i-1)/4]^temp[32:25];

		end
		w[i] = w[i-4] ^ temp;
	end
	w2=w1;
	w5= w[5]; w6= w[6]; w7= w[7]; w8= w[8]; w9= w[9]; w10= w[10]; w11= w[11]; w12= w[12]; w13= w[13]; w14= w[14]; w15= w[15]; w16= w[16]; w17= w[17]; w18= w[18]; w19= w[19]; w20= w[20]; w21= w[21]; w22= w[22]; w23= w[23]; w24= w[24]; w25= w[25]; w26= w[26]; w27= w[27]; w28= w[28]; w29= w[29]; w30= w[30]; w31= w[31]; w32= w[32]; w33= w[33]; w34= w[34]; w35= w[35]; w36= w[36]; w37= w[37]; w38= w[38]; w39= w[39]; w40= w[40]; w41= w[41]; w42= w[42]; w43= w[43]; w44= w[44];
	end
endmodule
