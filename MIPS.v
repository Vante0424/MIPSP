
`include "define.v"
module MIPS(
    input wire clk,
    input wire rst,
    input wire [31:0] instruction,
    output wire romCe,
    output wire [31:0] instAddr,
    
    output wire ramCe, ramWr,
    output wire [31:0] ramAddr,
    output wire [31:0] ramRdData,
    output wire [31:0] ramWtData,
    
    output wire ioCe, ioWr,
    output wire [31:0] ioAddr,
    output wire [31:0] ioRdData,
    output wire [31:0] ioWtData
);
    wire [31:0] regaData_regFile, regbData_regFile;
    wire [31:0] regaData_id, regbData_id; 
    wire [31:0] regcData_ex,regData;   
    wire regaRead, regbRead;
    wire [4:0] regaAddr, regbAddr,regWr;
    wire regcWrite_id, regcWrite_ex;
    wire [4:0] regcAddr_id, regcAddr_ex,regAddr;
	
	wire[31:0] jAddr_id;
	wire jCe_id;
	  
	wire [5:0] op_i;
    wire [5:0] op;
    wire [31:0] memAddr_ex;
    wire [31:0] memData;
	
	wire [31:0] wHiData;
	wire [31:0] wLoData;
	wire whi;
	wire wlo;
	wire [31:0] rHiData;
	wire [31:0] rLoData;
	
	wire memCe_mem, memWr_mem;   
  wire [31:0] memAddr_mem;
  wire [31:0] rdData_mem;
  wire [31:0] wtData_mem;
    

    IF pc0(
        .clk(clk),
        .rst(rst),
        .ce(romCe), 
        .pc(instAddr),
		
		    .jAddr(jAddr_id),
		    .jCe(jCe)
    );
    ID id0(
        .rst(rst),        
        .inst(instruction),
        .regaData_i(regaData_regFile),
        .regbData_i(regbData_regFile),
        .op(op_i),
        .regaData(regaData_id),
        .regbData(regbData_id),
        .regaRead(regaRead),
        .regbRead(regbRead),
        .regaAddr(regaAddr),
        .regbAddr(regbAddr),
        .regcWrite(regcWrite_id),
        .regcAddr(regcAddr_id),
		
		    .pc(instAddr),
		    .jAddr(jAddr_id),
		    .jCe(jCe)
    );
    EX ex0(
        .rst(rst),
        .op_i(op_i),        
        .regaData(regaData_id),
        .regbData(regbData_id),
        .regcWrite_i(regcWrite_id),
        .regcAddr_i(regcAddr_id),
        .regcData(regcData_ex),
        .regcWrite(regcWrite_ex),
        .regcAddr(regcAddr_ex),
        
        .op(op),
        .memAddr(memAddr_ex),
        .memData(memData),
		
		.wHiData(wHiData),
		.wLoData(wLoData),
		.whi(whi),
		.wlo(wlo),
		.rHiData(rHiData),
		.rLoData(rLoData)
    );    
    RegFile regfile0(
        .clk(clk),
        .rst(rst),
        .we(regWr),
        .waddr(regAddr),
        .wdata(regData),
        .regaRead(regaRead),
        .regbRead(regbRead),
        .regaAddr(regaAddr),
        .regbAddr(regbAddr),
        .regaData(regaData_regFile),
        .regbData(regbData_regFile)
    );
    
    MEM mem0(
        .rst(rst),		
		  .op(op),
		  .regcData(regcData_ex),
		  .regcAddr(regcAddr_ex),
		  .regcWr(regcWrite_ex),
		  .memAddr_i(memAddr_ex),
		  .memData(memData),	
		  .rdData(rdData_mem),
		  .regAddr(regAddr),
		  .regWr(regWr),
		  .regData(regData),	
		  .memAddr(memAddr_mem),
		  .wtData(wtData_mem),
		  .memWr(memWr_mem),	
		  .memCe(memCe_mem)
    );
	
	HiLo hilo0(
		.rst(rst),
		.clk(clk),
		.wHiData(wHiData),
		.wLoData(wLoData),
		.whi(whi),
		.wlo(wlo),
		.rHiData(rHiData),
		.rLoData(rLoData)
	);
	MIOC mioc(
	    .memAddr(memAddr_mem),
		  .wtData(wtData_mem),
		  .memWr(memWr_mem),	
		  .memCe(memCe_mem),
		  .rdData(rdData_mem),
     
      .ramAddr(ramAddr),
		  .ramWtData(ramWtData),
		  .ramWe(ramWr),	
		  .ramCe(ramCe),
		  .ramRdData(ramRdData),  

      .ioAddr(ioAddr),
		  .ioWtData(ioWtData),
		  .ioWe(ioWr),	
		  .ioCe(ioCe),
		  .ioRdData(ioRdData)
	);
endmodule

