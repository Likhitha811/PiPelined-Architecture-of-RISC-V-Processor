`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2023 11:47:33 AM
// Design Name: 
// Module Name: memory
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


module memory(clk,rst,regwriteM,resultsrcM,memwriteM,aluresultM,writedataM,RdM,pcplus4M,
                regwriteW,resultsrcW,aluresultW,readdataW,RdW,pcplus4W,target);

input clk,rst;
input regwriteM,memwriteM;
input [1:0]resultsrcM;
input [31:0]aluresultM,writedataM,pcplus4M;
input [4:0]RdM;

output regwriteW;
output [1:0]resultsrcW;
output [31:0]aluresultW,readdataW,pcplus4W;
output [4:0]RdW;

output [3:0]target;
wire [31:0]readdataM;

reg regwriteM_r;
reg [1:0]resultsrcM_r;
reg [31:0] aluresultM_r,readdataM_r,pcplus4M_r;
reg [4:0]RdM_r;

data_mem DMEM(.A(aluresultM),.datain(writedataM),.Rd(readdataM),.clk(clk),.write_enable(memwriteM),.target(target));

always@(posedge clk or negedge rst) begin
if(!rst) begin
regwriteM_r<=0;
resultsrcM_r<=2'b00;
aluresultM_r<=0;
readdataM_r<=0;
pcplus4M_r<=0;
RdM_r<=0;
end
else begin
regwriteM_r<=regwriteM;
resultsrcM_r<=resultsrcM;
aluresultM_r<=aluresultM;
readdataM_r<=readdataM;
pcplus4M_r<=pcplus4M;
RdM_r<=RdM;
end
end
assign regwriteW=regwriteM_r,
       resultsrcW=resultsrcM_r,
       aluresultW=aluresultM_r,
       readdataW=readdataM_r,
       pcplus4W=pcplus4M_r,
       RdW=RdM_r;
endmodule
