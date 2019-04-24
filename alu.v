`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 17:44:12
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] aluc,
    output reg [31:0] r,
    output reg zero,
    output reg carry,
    output reg negative,
    output reg overflow
    );
    reg signed [31:0] result;
    reg [31:0] c;
    always @(*)
    begin
    r=32'b0;
    carry=1'b0;
    negative=1'b0;
    overflow=1'b0;
    case(aluc)
    4'b0000: begin {carry,r[31:0]}=a+b; end
    4'b0010: begin result=$signed(a)+$signed(b); r=$signed(result); end
    4'b0001: begin r=a-b;if(a<b) carry=1; else carry=0;end
    4'b0011: begin result=$signed(a)-$signed(b); r=$signed(result); end
    4'b0100: begin r=a&b; end
    4'b0101: begin r=a|b; end
    4'b0110: begin r=a^b; end
    4'b0111: begin r=~(a|b); end
    4'b1000: begin r[31:0]={b[15:0],16'h0000}; end
    4'b1001: begin r[31:0]={b[15:0],16'h0000}; end
    4'b1011: begin r=($signed(a)<$signed(b))?1:0; if(r==1) negative=1; else negative=0;if(a==b) zero=1;else zero=0; end
    4'b1010: begin r=(a<b)?1:0; if(a<b) carry=1; else carry=0;if(a==b) zero=1;else zero=0; end
    4'b1100: begin r=$signed(b)>>>(a); end
    4'b1110: begin r=b<<(a); end
    4'b1111:begin r=b<<(a); end
    4'b1101: begin r=b>>(a); end
    endcase
    if(r==0) zero=1;
    else zero=0;
    if(r[31]==1) negative=1'b1; 
    else negative=1'b0; 
    if(aluc==4'b1011&&a<b) negative=1'b1; 
    else negative=1'b0;
    end
endmodule
