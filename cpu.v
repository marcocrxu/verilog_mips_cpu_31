`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 13:43:09
// Design Name: 
// Module Name: cpu
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


module cpu(
    input clk,
    input [4:0] Rsc,
    input [4:0] Rtc,
    input [4:0] Rdc,
    input RF_W,
    input RF_CLK,
    input [3:0] aluc,
    input M1,
    input M2,
    input M3,
    input M4,
    input M5,
    input M6,
    input M7,
    input M8,
    input M9,
    input reset,
    input sign,//需要带符号扩展置1
    input [31:0] cpu_dmem,
    input [31:0] inst,
    output [31:0] pc,
    output [31:0] alu,
    output [31:0] Rt,
    output z,
    output [31:0] ob3,
    output [31:0] ob4
);
    wire [4:0] pc_addr;
    assign pc_addr=5'b11111; 
    wire [31:0] pc_in;
    wire [31:0] npc;
    wire [31:0] Ext5_out;
    wire [31:0] Ext16_out;
    wire [31:0] Ext18_out;
    wire [31:0] MUX5_1;
    wire [31:0] MUX2_out;
    wire [31:0] MUX3_out;
    wire [31:0] MUX4_out;
    wire [31:0] MUX5_out;
    wire [4:0] MUX6_out;
    wire [31:0] MUX7_out;
    wire [4:0] MUX8_out;
    wire [31:0] MUX9_out;
    wire [31:0] Rs;
    wire [31:0] alu_out;
    wire [31:0] MUX1_0;
    wire [31:0] data_out;
    wire [31:0] data_in;
    assign MUX1_0={pc[31:28],inst[25:0],2'b0};
    npc NPC(.a(pc),.reset(reset),.c(npc));
    pcreg PC(.clk(clk),.rst(reset),.ena(1),.data_in(pc_in),.data_out(pc));
    MUX MUX1(.a(MUX7_out),.b(MUX1_0),.select(M1),.c(pc_in));
    Ext16 cpu_ext16(.IMEM15_0(inst[15:0]),.sign(sign),.Ext16_out(Ext16_out));
    Ext18 cpu_ext18(.IMEM15_0(inst[15:0]),.Ext18_out(Ext18_out));
    Ext5 cpu_ext5(.IMEM10_6(inst[10:6]),.Ext5_out(Ext5_out));
    add  cpu_add(.a(Ext18_out),.b(npc),.c(MUX5_1));
    MUX MUX5(.a(MUX5_1),.b(npc),.select(M5),.c(MUX5_out));
    MUX_5 MUX6(.a(Rtc),.b(MUX8_out),.select(M6),.c(MUX6_out));
    regfile cpu_ref(.Rsc(Rsc),.Rdc(MUX6_out),.Rtc(Rtc),.Rd(MUX9_out),.RF_CLK(clk),.Rs(Rs),.Rt(Rt),.RF_W(RF_W),.reset(reset));
    MUX MUX3(.a(Rs),.b(Ext5_out),.select(M3),.c(MUX3_out));
    MUX MUX4(.a(Ext16_out),.b(Rt),.select(M4),.c(MUX4_out));
    alu ALU(.a(MUX3_out),.b(MUX4_out),.aluc(aluc),.r(alu),.zero(z));
    MUX MUX2(.a(alu),.b(cpu_dmem),.select(M2),.c(MUX2_out));
    MUX MUX9(.a(MUX2_out),.b(npc),.select(M9),.c(MUX9_out));
    MUX MUX7(.a(MUX5_out),.b(MUX3_out),.select(M7),.c(MUX7_out));
    MUX_5 MUX8(.a(Rdc),.b(pc_addr),.select(M8),.c(MUX8_out));
    assign ob3=MUX3_out;
    assign ob4=MUX4_out;
endmodule

module add(
    input [31:0] a,
    input [31:0] b,
    output [31:0] c
);
    assign c=a+b;
endmodule

module regfile(
    input RF_CLK, 
    input [4:0] Rdc,
    input [31:0] Rd,
    input [4:0] Rsc,
    input [4:0] Rtc,
    input reset,
    input RF_W,
    output [31:0] Rs,
    output [31:0] Rt
);
    reg [31:0] array_reg [31:0];
    assign Rs=array_reg[Rsc];
    assign Rt=array_reg[Rtc];
    always @(negedge RF_CLK)
    begin
        if(reset==1) 
        begin
            array_reg[0]<=0;
            array_reg[1]<=0;
            array_reg[2]<=0;
            array_reg[3]<=0;
            array_reg[4]<=0;
            array_reg[5]<=0;
            array_reg[6]<=0;
            array_reg[7]<=0;
            array_reg[8]<=0;
            array_reg[9]<=0;
            array_reg[10]<=0;
            array_reg[11]<=0;
            array_reg[12]<=0;
            array_reg[13]<=0;
            array_reg[14]<=0;
            array_reg[15]<=0;
            array_reg[16]<=0;
            array_reg[17]<=0;
            array_reg[18]<=0;
            array_reg[19]<=0;
            array_reg[20]<=0;
            array_reg[21]<=0;
            array_reg[22]<=0;
            array_reg[23]<=0;
            array_reg[24]<=0;
            array_reg[25]<=0;
            array_reg[26]<=0;
            array_reg[27]<=0;
            array_reg[28]<=0;
            array_reg[29]<=0;
            array_reg[30]<=0;
            array_reg[31]<=0;
        end
        else begin
            if(RF_W) begin
                array_reg[Rdc]<=Rd;
                array_reg[0]<=0;
            end
        end
   end
   
   always@(posedge RF_CLK)
   begin
       if(reset==1) 
       begin
            array_reg[0]<=0;
            array_reg[1]<=0;
            array_reg[2]<=0;
            array_reg[3]<=0;
            array_reg[4]<=0;
            array_reg[5]<=0;
            array_reg[6]<=0;
            array_reg[7]<=0;
            array_reg[8]<=0;
            array_reg[9]<=0;
            array_reg[10]<=0;
            array_reg[11]<=0;
            array_reg[12]<=0;
            array_reg[13]<=0;
            array_reg[14]<=0;
            array_reg[15]<=0;
            array_reg[16]<=0;
            array_reg[17]<=0;
            array_reg[18]<=0;
            array_reg[19]<=0;
            array_reg[20]<=0;
            array_reg[21]<=0;
            array_reg[22]<=0;
            array_reg[23]<=0;
            array_reg[24]<=0;
            array_reg[25]<=0;
            array_reg[26]<=0;
            array_reg[27]<=0;
            array_reg[28]<=0;
            array_reg[29]<=0;
            array_reg[30]<=0;
            array_reg[31]<=0;
        end
        else begin
            array_reg[0]<=0;
        end
   end
endmodule

module pcreg(
    input clk,
    input rst,
    input ena,
    input [31:0] data_in,
    output [31:0] data_out
    );
    reg [31:0] data;
    assign data_out=data;
    
    always @(posedge clk)
    begin
        if(rst==1)
            data<=32'h00400000;
    end
    
    always @(negedge clk)
    begin
    if(rst==1) 
        data<=32'h00400000;
    else begin
        if(ena==1) 
            data<=data_in;
    end
    end
endmodule

module Ext18(
    input [15:0] IMEM15_0,
    output [31:0] Ext18_out
    );
    assign Ext18_out=(IMEM15_0[15]==1)?{14'h3fff,IMEM15_0,2'b0}:{14'b0,IMEM15_0,2'b0};
endmodule

module Ext5(
    input [4:0] IMEM10_6,
    output [31:0] Ext5_out
    );
    assign Ext5_out={27'b0,IMEM10_6};
endmodule


