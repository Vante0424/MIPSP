`include "define.v"
module IF(
    input wire clk,
    input wire rst,
    output reg ce, 
	output reg [31:0] pc,
	
	input wire[31:0] jAddr,
	input wire jCe
);
    always@(*)
        if(rst == `RstEnable)
            ce = `RomDisable;
        else
            ce = `RomEnable;
			
    always@(posedge clk)
    if(ce == `RomDisable)
        pc = `Zero;
    else if(jCe== `Valid)
	    pc = jAddr;
	else
        pc = pc + 4;
endmodule
