`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2023 11:09:02 AM
// Design Name: 
// Module Name: execute
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


module execute(clk,rst,regwriteE,resultsrcE,memwriteE,jumpE,branchE,alucontrolE,alusrcE,
                Rd1E,Rd2E,pcE,RdE,ImmextE,pcplus4E,pctargetE,pcsrcE,regwriteM,resultsrcM,memwriteM,
                aluresultM,writedataM,RdM,pcplus4M,forwardAE,forwardBE,resultW);
                
input clk,rst,regwriteE,memwriteE,jumpE,branchE,alusrcE;
input [2:0]alucontrolE;
input [31:0]pcE,ImmextE,pcplus4E,Rd1E,Rd2E,resultW;
input [4:0]RdE;
input [1:0]resultsrcE;
input [1:0]forwardAE,forwardBE;
output regwriteM,memwriteM,pcsrcE;
output [31:0] writedataM,aluresultM,pcplus4M,pctargetE;
output [4:0]RdM;
output [1:0]resultsrcM;

wire [31:0]srcBE,aluresultE,zeroE,srcA,srcB_inter;
wire andout_1;

reg regwriteE_r,memwriteE_r;
reg [31:0] Rd2E_r,aluresultE_r,pcplus4E_r;
reg [4:0]RdE_r;
reg [1:0]resultsrcE_r;


alu  ALU(.a(srcA),.b(srcBE),.sel(alucontrolE),.alu_out(aluresultE),.zf(zeroE));

adder  AD1(.in1(pcE),.in2(ImmextE),.out(pctargetE));

mux  ALU_MUX(.in1(srcB_inter),.in2(ImmextE),.s(alusrcE),.out(srcBE));


mux3  forward_muxA(.a0(Rd1E),.a1(resultW),.a2(aluresultM),.s(forwardAE),.y(srcA));

mux3 forward_muxB(.a0(Rd2E),.a1(resultW),.a2(aluresultM),.s(forwardBE),.y(srcB_inter));


and and1(andout_1,zeroE,branchE);
or or1(pcsrcE,andout_1,jumpE);

always@(posedge clk or negedge rst) begin
if(!rst) begin
regwriteE_r<=0;
memwriteE_r<=0;
Rd2E_r<=0;
aluresultE_r<=0;
pcplus4E_r<=0;
RdE_r<=0;
resultsrcE_r<=2'b00;
end
else begin
regwriteE_r<=regwriteE;
memwriteE_r<=memwriteE;
Rd2E_r<=srcB_inter;
aluresultE_r<=aluresultE;
pcplus4E_r<=pcplus4E;
RdE_r<=RdE;
resultsrcE_r<=resultsrcE;
end
end
assign regwriteM=regwriteE_r,
       resultsrcM=resultsrcE_r,
       memwriteM=memwriteE_r,
       aluresultM=aluresultE_r,
       writedataM=Rd2E_r,
       RdM=RdE_r,
       pcplus4M=pcplus4E_r;
endmodule
