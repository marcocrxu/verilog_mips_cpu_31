`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/26 22:13:48
// Design Name: 
// Module Name: de_selector14
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


module de_selector14(
    input iC,
    input iS0,
    input iS1,
    output oZ0,
    output oZ1,
    output oZ2,
    output oZ3
    );
    assign oZ0=~((~iC)&(~iS0)&(~iS1));
    assign oZ1=~((~iC)&(~iS0)&(iS1));
    assign oZ2=~((~iC)&(iS0)&(~iS1));
    assign oZ3=~((~iC)&(iS0)&(iS1));
endmodule
