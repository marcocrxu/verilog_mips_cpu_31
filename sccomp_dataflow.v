`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 13:39:26
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc,
    output [31:0] alu,
    output [31:0] ob3,
    output [31:0] ob4,
    output [31:0] data_out,
    output [31:0] Rt,
    output reg [3:0] aluc=4'b0
    );
    wire [31:0] data;
    /*控制信号*/
    reg PC_ena=1;
    reg [4:0] Rsc;
    reg [4:0] Rdc;
    reg [4:0] Rtc;
    reg RF_W=1;
    reg RF_CLK=0;
    reg M1=0;
    reg M2=0;
    reg M3=0;
    reg M4=0;
    reg [1:0] b=0;//beq||bne
    reg M6=0;
    reg M7=0;
    reg M8=0;
    reg DM_R=1;
    reg CM_CS;
    reg DM_W=0;
    reg M9=1;
    wire M5;
    wire eq_ne;
    //wire [31:0] Rt; 
    wire pc_ena_net;
    wire [31:0] pc_net;
    assign pc_net=pc;
    wire z;
    reg sign=0;
    wire [31:0] data_in;
    //wire [31:0] data_out;
    assign M5=(b[1]==1)?eq_ne:0;
    assign eq_ne=(b[0]==1)?z:~z;
    
    imem imem(.a(pc[12:2]),.spo(inst));
    dmem dmem(.a(alu[12:2]),.d(Rt),.clk(clk_in),.we(DM_W),.spo(data_out));

    cpu sccpu(
      .ob3(ob3),
      .ob4(ob4),
      .Rt(Rt),
      .clk(clk_in),     //cpu时钟
      .reset(reset),
      .cpu_dmem(data_out),
      .Rsc(Rsc),     //Rs的地址
      .Rdc(Rdc),     //Rd的地址
      .Rtc(Rtc),     //Rt的地址
      .RF_W(RF_W),    //寄存器是都是写 
      .RF_CLK(clk_in),  //寄存器的时钟
      .aluc(aluc),    //计算的符号
      .inst(inst),
      .M1(M1),.M2(M2),.M3(M3),.M4(M4),.M5(M5),.M6(M6),.M7(M7),.M8(M8),.M9(M9),    //8个选择器
      .sign(sign),
      .z(z),        //为0
      .pc(pc),      //pc信号
      .alu(alu));    //DMEM输入
    always @(inst)
    begin
        case(inst[31:26])
        6'b000000:begin
            case(inst[5:0])
            6'b100000:begin   //add
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0010;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;
                sign=1;                                            
            end
            6'b100001:begin  //addu
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0000;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0; 
                sign=0;                                           
            end
            6'b100010:begin  //sub
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0011;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;        
                sign=1;                                            
            end                                    
            6'b100011:begin //subu
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0001;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                                
                sign=0;                                            
            end
            6'b100100:begin //and
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0100;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                                
                sign=0;                                            
            end
            6'b100101:begin //or
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0101;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                                
                sign=0;                                            
            end
            6'b100110:begin //xor
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0110;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
                sign=0;                                            
            end
            6'b100111:begin //nor
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0111;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                            
                sign=0;                                            
            end
            6'b101010:begin //slt
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b1011;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
                sign=0;                                            
            end
            6'b101011:begin //sltu
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b1010;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
                sign=0;                                            
            end
            6'b000000:begin //sll
                PC_ena<=1;Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=0;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b1111;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                                
                sign=0;                                            
            end
            6'b000010:begin //srl
                PC_ena<=1;Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=0;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M7<=1;M8<=1;M9=1;aluc<=4'b1101;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                            
                sign=0;                                            
            end
            6'b000011:begin //sra
                PC_ena<=1;Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=0;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b1100;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                        
                sign=0;                                            
            end
            6'b000100:begin //sllv
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b1111;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
                sign=0;                                            
           end
           6'b000110:begin  //srlv
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b1101;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                           
                sign=0;                                            
           end
           6'b000111:begin  //srav
                PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];Rdc<=inst[15:11];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b1100;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                           
                sign=0;                                            
           end
           6'b001000:begin  //jr
                PC_ena<=1;Rsc<=inst[25:21];M1<=1;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=0;M8<=0;M9=1;aluc<=4'b0111;RF_W<=0;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                           
                sign=0;                                            
           end
        endcase
        end
        6'b001000:begin //addi
            PC_ena<=1;Rsc<=inst[25:21];Rdc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=1;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0010;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
            sign=1;                                            
        end
        6'b001001:begin //addiu
            PC_ena<=1;Rsc<=inst[25:21];Rdc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=1;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0010;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                                        
            sign=1;                                            
        end
        6'b001100:begin //andi
            PC_ena<=1;Rsc<=inst[25:21];Rdc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=1;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0100;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
            sign=0;                                            
        end 
        6'b001101:begin //ori
            PC_ena<=1;Rsc<=inst[25:21];Rdc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=1;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0101;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
            sign=0;                                            
        end
        6'b001110:begin //xori
            PC_ena<=1;Rsc<=inst[25:21];Rdc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=1;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0110;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
            sign=0;                                            
        end
        6'b100011:begin //lw
            PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];M1<=1;M2<=0;M3<=1;M4<=1;b<=0;M6<=1;M7<=1;M8<=1;M9=1;aluc<=4'b0000;RF_W<=1;RF_CLK<=1;CM_CS<=1;DM_R<=1;DM_W<=0;                                                            
            sign=0;                                            
        end
        6'b101011:begin //sw
            PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=1;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0000;RF_W<=0;RF_CLK<=1;CM_CS<=1;DM_R<=0;DM_W<=1;                                                            
            sign=0;                                            
        end
        6'b000100:begin //beq
            PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=0;b=2'b11;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0001;RF_W<=0;RF_CLK<=0;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
            sign=0;                                            
        end
        6'b000101:begin //bne
            PC_ena<=1;Rsc<=inst[25:21];Rtc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=0;b<=2'b10;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0001;RF_W<=0;RF_CLK<=0;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
            sign=0;                                            
        end
        6'b001010:begin //slti
            PC_ena<=1;Rsc<=inst[25:21];Rdc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=1;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b1011;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                                        
            sign=1;                                            
        end
        6'b001011:begin //sltiu
            PC_ena<=1;Rsc<=inst[25:21];Rdc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=1;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b1010;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                                        
            sign=0;                                            
        end
        6'b001111:begin //lui
            PC_ena<=1;Rtc<=inst[20:16];M1<=1;M2<=1;M3<=1;M4<=1;b<=0;M6<=1;M7<=1;M8<=1;M9=1;aluc<=4'b1000;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                                   
            sign=0;                                            
        end
        6'b000010:begin //j
            PC_ena<=1;M1<=0;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=1;M9=1;aluc<=4'b0000;RF_W<=0;RF_CLK<=0;CM_CS<=0;DM_R<=0;DM_W<=0;                                                         
            sign=0;                                            
        end
        6'b000011:begin //jal
            PC_ena<=1;M1<=0;M2<=1;M3<=1;M4<=0;b<=0;M6<=0;M7<=1;M8<=0;M9=0;aluc<=4'b0000;RF_W<=1;RF_CLK<=1;CM_CS<=0;DM_R<=0;DM_W<=0;                                                            
            sign=0;                                            
        end
    endcase
    end
endmodule
