`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2023 10:21:40 AM
// Design Name: 
// Module Name: decode
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


module decode(clk,rst,pcD,pcplus4D,instrD,regwriteW,RdW,resultW,regwriteE,resultsrcE,
               memwriteE,jumpE,branchE,alucontrolE,alusrcE,Rd1E,Rd2E,pcE,RdE,ImmextE,pcplus4E,Rs1E,Rs2E);
               
input clk,rst,regwriteW;
input [31:0]resultW,instrD,pcD,pcplus4D;
input [4:0]RdW;
output regwriteE, memwriteE,jumpE,branchE,alusrcE;
output [1:0]resultsrcE;
output [2:0]alucontrolE;
output [31:0]pcplus4E,ImmextE,Rd1E,Rd2E,pcE;
output [4:0]RdE,Rs1E,Rs2E;

wire regwriteD, memwriteD,jumpD,branchD,alusrcD;
wire [2:0]alucontrolD;
wire [31:0]ImmextD,Rd1D,Rd2D;
wire [4:0]RdD,rs1d,rs2d;
wire [1:0]immsrcD,resultsrcD;

assign RdD=instrD[11:7];
assign rs1d=instrD[19:15],
        rs2d=instrD[24:20];
reg regwriteD_r, memwriteD_r,jumpD_r,branchD_r,alusrcD_r;
reg [1:0] resultsrcD_r;
reg [2:0]alucontrolD_r;
reg [31:0]ImmextD_r,Rd1D_r,Rd2D_r,pcplus4D_r,pcD_r;
reg [4:0]RdD_r,Rs1D_r,Rs2D_r;


control_unit  CU(.op(instrD[6:0]),.funct3(instrD[14:12]),.funct7(instrD[30]),.resultsrc(resultsrcD),.memwrite(memwriteD),
                .alusrc(alusrcD),.regwrite(regwriteD),.immsrc(immsrcD),.alucontrol(alucontrolD),.branch(branchD),.jump(jumpD));
                
register_file  RF(.clk(clk),.reset(rst),.we3(regwriteW),.wd3(resultW),.ra1(rs1d),.ra2(rs2d),.wa3(RdW),.rd1(Rd1D),.rd2(Rd2D));

sign_extent  SE(.in(instrD[31:7]),.immsrc(immsrcD),.immext(ImmextD));


always@(posedge clk or negedge rst) begin
if(!rst) begin
regwriteD_r<=0;
resultsrcD_r<=2'b00;
memwriteD_r<=0;
jumpD_r<=0;
branchD_r<=0;
alusrcD_r<=0;
alucontrolD_r<=3'b000;
ImmextD_r<=0;
Rd1D_r<=0;
Rd2D_r<=0;
pcplus4D_r<=0;
pcD_r<=0;
RdD_r<=0;
Rs1D_r<=0;
Rs2D_r<=0;
end
else begin
regwriteD_r<=regwriteD;
resultsrcD_r<=resultsrcD;
memwriteD_r<=memwriteD;
jumpD_r<=jumpD;
branchD_r<=branchD;
alusrcD_r<=alusrcD;
alucontrolD_r<=alucontrolD;
ImmextD_r<=ImmextD;
Rd1D_r<=Rd1D;
Rd2D_r<=Rd2D;
pcplus4D_r<=pcplus4D;
pcD_r<=pcD;
RdD_r<=RdD;
Rs1D_r<=instrD[19:15];
Rs2D_r<=instrD[24:20];
end
end

assign regwriteE=regwriteD_r,
       resultsrcE=resultsrcD_r,
       memwriteE=memwriteD_r,
       jumpE=jumpD_r,
       branchE=branchD_r,
       alucontrolE=alucontrolD_r,
       alusrcE=alusrcD_r,
       Rd1E=Rd1D_r,
       Rd2E=Rd2D_r,
       pcE=pcD_r,
       RdE=RdD_r,
       ImmextE=ImmextD_r,
       pcplus4E=pcplus4D_r,
       Rs1E=Rs1D_r,
       Rs2E=Rs2D_r;
endmodule
