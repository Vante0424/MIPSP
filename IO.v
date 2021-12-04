`include "define.v"
module IO(
    input wire clk,
    input wire ce,
    input wire we,
    input wire [31:0] addr,
    input wire [31:0] dataIn,
    output reg [31:0] dataOut
);

    reg [31:0] iomem [1023 : 0];
    always@(*)      
        if(ce == `RamDisable)
          dataOut = `Zero;
        else
          dataOut = iomem[addr[11 : 2]]; 
    always@(posedge clk)
        if(ce == `RamEnable && we == `RamWrite)
            iomem[addr[11 : 2]] = dataIn;
        else ;
          
endmodule



