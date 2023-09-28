`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2023 12:13:30 PM
// Design Name: 
// Module Name: writeback
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


module writeback(clk,rst,aluresultW,readdataW,pcplus4W,resultsrcW,resultW);
input clk,rst;
input [31:0]aluresultW,readdataW,pcplus4W;
input [1:0]resultsrcW;
output [31:0]resultW;

mux3  Result_mux(.a0(aluresultW),.a1(readdataW),.a2(pcplus4W),.s(resultsrcW),.y(resultW));

endmodule
