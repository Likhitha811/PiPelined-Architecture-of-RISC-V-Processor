`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2023 10:08:53 AM
// Design Name: 
// Module Name: fetch
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


module fetch(clk,rst,pcsrcE,pctargetE,instrD,pcplus4D,pcD);
input clk,rst,pcsrcE;
input [31:0]pctargetE;
output [31:0]instrD,pcplus4D,pcD;

wire [31:0]pcplus4F,pc_F,pcF,instrF;

reg [31:0]instrF_r,pcF_r,pcplus4F_r;

mux pc_mux(.in1(pcplus4F),.in2(pctargetE),.s(pcsrcE),.out(pc_F));

pc_reg program_counter(.pc_next(pc_F),.pc(pcF),.clk(clk),.reset(rst));

instr_mem IMEM(.pc(pcF),.instr(instrF));

adder ad(.in1(pcF),.in2(32'd1),.out(pcplus4F));

always@(posedge clk or negedge rst) begin
if(!rst) begin
pcF_r<=0;
pcplus4F_r<=0;
instrF_r<=0;
end
else begin
pcF_r<=pcF;
pcplus4F_r<=pcplus4F;
instrF_r<=instrF;
end
end

assign instrD=instrF_r,
       pcplus4D=pcplus4F_r,
       pcD=pcF_r;
endmodule
