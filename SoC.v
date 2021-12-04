
module SoC(
    input wire clk,
    input wire rst
);
    wire [31:0] instAddr;
    wire [31:0] instruction;
    wire romCe;
    
    wire ramCe, ramWr;    
    wire [31:0] ramAddr;
    wire [31:0] ramRdData;
    wire [31:0] ramWtData;
    
    wire ioCe, ioWr;    
    wire [31:0] ioAddr;
    wire [31:0] ioRdData;
    wire [31:0] ioWtData;
    
    MIPS mips0(
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .instAddr(instAddr),
        .romCe(romCe),
        
        .ramRdData(ramRdData),        
        .ramWtData(ramWtData),        
        .ramAddr(ramAddr),        
        .ramCe(ramCe),        
        .ramWr(ramWr),
        
        .ioRdData(ioRdData),        
        .ioWtData(ioWtData),        
        .ioAddr(ioAddr),        
        .ioCe(ioCe),        
        .ioWr(ioWr)    

    );
    
    InstMem instrom0(
        .ce(romCe),
        .addr(instAddr),
        .data(instruction)
    );
    
    DataMem datamem0(       
        .ce(ramCe),        
        .clk(clk),        
        .we(ramWr),        
        .addr(ramAddr),        
        .dataOut(ramRdData),        
        .dataIn(ramWtData)   
    );
    
    IO io0(       
        .ce(ioCe),        
        .clk(clk),        
        .we(ioWr),        
        .addr(ioAddr),        
        .dataOut(ioRdData),        
        .dataIn(ioWtData)   
    );

endmodule

