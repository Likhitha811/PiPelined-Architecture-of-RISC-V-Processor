`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2023 12:19:25 PM
// Design Name: 
// Module Name: riscv_top
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


module riscv_top(clk,rst,an,ca);
input clk,rst;
output reg [7:0]ca;
output [3:0]an;
assign an=4'b1110;

wire pcsrcE,regwriteW,memwriteE,jumpE,branchE,alusrcE,regwriteE,regwriteM,memwriteM;
wire [31:0]pctargetE,instrD,pcplus4D,pcD,resultW,Rd1E,Rd2E,pcE,ImmextE,pcplus4E;
wire [4:0]RdW,RdE,RdM,Rs1E,Rs2E;
wire [1:0]resultsrcE,resultsrcM,resultsrcW;
wire [2:0]alucontrolE;
wire [31:0]aluresultM,writedataM,pcplus4M,aluresultW,readdataW,pcplus4W;
wire [1:0]forwardAE,forwardBE;
wire [3:0]target;

integer i;
reg clk1;
reg [3:0]digit;




fetch Fetch(clk1,rst,pcsrcE,pctargetE,instrD,pcplus4D,pcD);

decode Decode(clk1,rst,pcD,pcplus4D,instrD,regwriteW,RdW,resultW,regwriteE,resultsrcE,
               memwriteE,jumpE,branchE,alucontrolE,alusrcE,Rd1E,Rd2E,pcE,RdE,ImmextE,pcplus4E,Rs1E,Rs2E);
               

execute Execute(clk1,rst,regwriteE,resultsrcE,memwriteE,jumpE,branchE,alucontrolE,alusrcE,
                Rd1E,Rd2E,pcE,RdE,ImmextE,pcplus4E,pctargetE,pcsrcE,regwriteM,resultsrcM,memwriteM,
                aluresultM,writedataM,RdM,pcplus4M,forwardAE,forwardBE,resultW);
                
memory Memory(clk1,rst,regwriteM,resultsrcM,memwriteM,aluresultM,writedataM,RdM,pcplus4M,
                regwriteW,resultsrcW,aluresultW,readdataW,RdW,pcplus4W,target);
                
writeback WriteBack(clk1,rst,aluresultW,readdataW,pcplus4W,resultsrcW,resultW);

hazard_unit Hazard(rst,regwriteM,regwriteW,RdM,RdW,Rs1E,Rs2E,forwardAE,forwardBE);



always@(posedge clk)
begin
if(i==50000000) begin
clk1=~clk1;
i=0;
end
else
i=i+1;
end



always@(posedge clk) begin
digit<=resultW[3:0];
end
always@(posedge clk)
begin
case(digit)
4'b0000:ca=8'b00000011;
4'b0001:ca=8'b10011111;
4'b0010:ca=8'b00100101;
4'b0011:ca=8'b00001101;
4'b0100:ca=8'b10011001;
4'b0101:ca=8'b01001001;
4'b0110:ca=8'b01000001;
4'b0111:ca=8'b00011111;
4'b1000:ca=8'b00000001;
4'b1001:ca=8'b00001001;
endcase
end

endmodule
