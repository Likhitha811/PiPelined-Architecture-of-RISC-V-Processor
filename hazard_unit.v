`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2023 03:18:13 PM
// Design Name: 
// Module Name: hazard_unit
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


module hazard_unit(rst,regwriteM,regwriteW,RdM,RdW,Rs1E,Rs2E,forwardAE,forwardBE);

input rst,regwriteM,regwriteW;
input [4:0]RdM,RdW,Rs1E,Rs2E;

output [1:0]forwardAE,forwardBE;



assign forwardAE=(rst==1'b0)?2'b00:
        ((regwriteM==1'b1)&(RdM!=0)&(RdM==Rs1E))?2'b10:
        ((regwriteW==1'b1)&(RdW!=0)&(RdW==Rs1E))?2'b01:2'b00;
        
        
assign forwardBE=(rst==1'b0)?2'b00:((regwriteM==1'b1)&(RdM!=0)&(RdM==Rs2E))?2'b10:
        ((regwriteW==1'b1)&(RdW!=0)&(RdW==Rs2E))?2'b01:2'b00;
        
                
endmodule
