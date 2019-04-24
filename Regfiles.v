`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/22 13:39:24
// Design Name: 
// Module Name: Regfiles
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

module Regfiles(
   input clk,
   input rst,
   input we,
   input [4:0] raddr1,
   input [4:0] raddr2,
   input [4:0] waddr,
   input [31:0] wdata,
   output wire [31:0] rdata1,
   output wire [31:0] rdata2
    );
    wire [31:0] ena;
    wire [31:0] decode;
    wire [31:0] result [31:0];
    decoder decod(waddr,we,decode);
    pcreg reg1(clk,rst,decode[0],wdata,result[0]);
    pcreg reg2(clk,rst,decode[1],wdata,result[1]);
    pcreg reg3(clk,rst,decode[2],wdata,result[2]);
    pcreg reg4(clk,rst,decode[3],wdata,result[3]);
    pcreg reg5(clk,rst,decode[4],wdata,result[4]);
    pcreg reg6(clk,rst,decode[5],wdata,result[5]);
    pcreg reg7(clk,rst,decode[6],wdata,result[6]);
    pcreg reg8(clk,rst,decode[7],wdata,result[7]);
    pcreg reg9(clk,rst,decode[8],wdata,result[8]);
    pcreg reg10(clk,rst,decode[9],wdata,result[9]);
    pcreg reg11(clk,rst,decode[10],wdata,result[10]);
    pcreg reg12(clk,rst,decode[11],wdata,result[11]);
    pcreg reg13(clk,rst,decode[12],wdata,result[12]);
    pcreg reg14(clk,rst,decode[13],wdata,result[13]);
    pcreg reg15(clk,rst,decode[14],wdata,result[14]);
    pcreg reg16(clk,rst,decode[15],wdata,result[15]);
    pcreg reg17(clk,rst,decode[16],wdata,result[16]);
    pcreg reg18(clk,rst,decode[17],wdata,result[17]);
    pcreg reg19(clk,rst,decode[18],wdata,result[18]);
    pcreg reg20(clk,rst,decode[19],wdata,result[19]);
    pcreg reg21(clk,rst,decode[20],wdata,result[20]);
    pcreg reg22(clk,rst,decode[21],wdata,result[21]);
    pcreg reg23(clk,rst,decode[22],wdata,result[22]);
    pcreg reg24(clk,rst,decode[23],wdata,result[23]);
    pcreg reg25(clk,rst,decode[24],wdata,result[24]);
    pcreg reg26(clk,rst,decode[25],wdata,result[25]);
    pcreg reg27(clk,rst,decode[26],wdata,result[26]);
    pcreg reg28(clk,rst,decode[27],wdata,result[27]);
    pcreg reg29(clk,rst,decode[28],wdata,result[28]);
    pcreg reg30(clk,rst,decode[29],wdata,result[29]);
    pcreg reg31(clk,rst,decode[30],wdata,result[30]);
    pcreg reg32(clk,rst,decode[31],wdata,result[31]);
    selector_32 selector1(result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15],result[16],result[17],result[18],result[19],result[20],result[21],result[22],result[23],result[24],result[25],result[26],result[27],result[28],result[29],result[30],result[31],raddr1,~we,rdata1);
    selector_32 selector2(result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15],result[16],result[17],result[18],result[19],result[20],result[21],result[22],result[23],result[24],result[25],result[26],result[27],result[28],result[29],result[30],result[31],raddr2,~we,rdata2);
endmodule


module decoder(
    input [4:0] iData,
    input iEna,
    output [31:0] decode
    );
    assign decode=((iEna)?(1<<iData):31'b0);
endmodule

module pcreg(
    input clk,
    input rst,
    input ena,
    input [31:0] data_in,
    output reg [31:0] data_out
    );
    always @(posedge clk or negedge rst)
    begin
    if(rst==1) data_out=32'b0;
    else
    begin
    if(ena==1) data_out=data_in;
    else data_out=data_out;
    end
    end
endmodule

module selector_32(
    input [31:0] iC0,
    input [31:0] iC1,
    input [31:0] iC2,
    input [31:0] iC3,
    input [31:0] iC4,
    input [31:0] iC5,
    input [31:0] iC6,
    input [31:0] iC7,
    input [31:0] iC8,
    input [31:0] iC9,
    input [31:0] iC10,
    input [31:0] iC11,
    input [31:0] iC12,
    input [31:0] iC13,
    input [31:0] iC14,
    input [31:0] iC15,
    input [31:0] iC16,
    input [31:0] iC17,
    input [31:0] iC18,
    input [31:0] iC19,
    input [31:0] iC20,
    input [31:0] iC21,
    input [31:0] iC22,
    input [31:0] iC23,
    input [31:0] iC24,
    input [31:0] iC25,
    input [31:0] iC26,
    input [31:0] iC27,
    input [31:0] iC28,
    input [31:0] iC29,
    input [31:0] iC30,
    input [31:0] iC31,
    input [4:0] raddr,
    input en,
    output reg [31:0] oZ
    );
    always @(*)
    begin
    if(en==1)
    begin
    case(raddr)
    5'b00000: oZ=iC0;
    5'b00001: oZ=iC1;
    5'b00010: oZ=iC2;
    5'b00011: oZ=iC3;
    5'b00100: oZ=iC4;
    5'b00101: oZ=iC5;
    5'b00110: oZ=iC6;
    5'b00111: oZ=iC7;
    5'b01000: oZ=iC8;
    5'b01001: oZ=iC9;
    5'b01010: oZ=iC10;
    5'b01011: oZ=iC11;
    5'b01100: oZ=iC12;
    5'b01101: oZ=iC13;
    5'b01110: oZ=iC14;
    5'b01111: oZ=iC15;
    5'b10000: oZ=iC16;
    5'b10001: oZ=iC17;
    5'b10010: oZ=iC18;
    5'b10011: oZ=iC19;
    5'b10100: oZ=iC20;
    5'b10101: oZ=iC21;
    5'b10110: oZ=iC22;
    5'b10111: oZ=iC23;
    5'b11000: oZ=iC24;
    5'b11001: oZ=iC25;
    5'b11010: oZ=iC26;
    5'b11011: oZ=iC27;
    5'b11100: oZ=iC28;
    5'b11101: oZ=iC29;
    5'b11110: oZ=iC30;
    5'b11111: oZ=iC31;
    endcase
    end
    else
    oZ=32'bz;
    end
endmodule