`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 14:29:49
// Design Name: 
// Module Name: MUX
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


module MUX(
    input [31:0] a,
    input [31:0] b,
    input select,
    output  [31:0] c
    );
    
//always @(*)
/*
begin
    case(select)
        1'b1:c <= b;
        1'b0:c <= a;
    endcase
end
*/
assign c=(select==1)?a:b;
endmodule

module MUX_5(
    input [4:0] a,
    input [4:0] b,
    input select,
    output [4:0] c
);
    assign c=(select==1)?a:b;
endmodule
