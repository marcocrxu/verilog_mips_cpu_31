`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 15:58:08
// Design Name: 
// Module Name: Ext16
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


module Ext16(
    input [15:0] IMEM15_0,
    input sign,
    output [31:0] Ext16_out
    );
    wire [31:0] sign_result;
    assign sign_result=(IMEM15_0[15]==1)?{16'hffff,IMEM15_0}:{16'b0,IMEM15_0};
    assign Ext16_out={sign==0}?{16'b0,IMEM15_0}:sign_result;
endmodule
