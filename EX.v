`include "define.v"
module EX(
    input wire rst,
    input wire [31:0] regaData,
    input wire [31:0] regbData,
    input wire regcWrite_i,
    input wire [4:0]regcAddr_i,
	
    output reg [31:0] regcData,
    output reg regcWrite,
    output reg [4:0] regcAddr,
    
    input wire [5:0] op_i,
    output wire [5:0] op,
    output wire [31:0] memAddr,
    output wire [31:0] memData,
	
	input wire [31:0] rHiData,
    input wire [31:0] rLoData,
	
	output reg [31:0] wHiData,
    output reg [31:0] wLoData,
    output reg whi,
    output reg wlo
);

    assign op = op_i;
    assign memAddr = regaData;
    assign memData = regbData;
    
    reg[31:0] Hi, Lo;

    always@(*)
        if(rst == `RstEnable)
            regcData = `Zero;
        else
          begin
				case(op_i)
				  `Add:
					regcData = regaData + regbData;
				  `Sub:
					regcData = regaData - regbData;
				  `And:
					regcData = regaData & regbData;
				  `Or:
					regcData = regaData | regbData;
				  `Xor:
					regcData = regaData ^ regbData;
				  `Sll:
					regcData = regbData << regaData;
				  `Srl:
					regcData = regbData >> regaData;
				  `Sra:
					regcData = ($signed(regbData)) >> regaData;
				  `Jal:
					regcData = regaData;	   
				  `Slt:
					if($signed(regaData)<$signed(regbData))
					  regcData = `One;
					else
					  regcData = `Zero;
				  default:
					regcData = `Zero;
				endcase
          end

    always@(*)
	if(rst == `RstEnable)
            begin
		whi=`Invalid;
		wlo=`Invalid;
	    end
        else
			begin
				whi=`Invalid;
				wlo=`Invalid;
				case(op_i)
					`Mult,
					`Multu:		        
						begin		    	
							{Hi,Lo} = $signed(regaData) * $signed(regbData);
							whi=`Valid;
							wlo=`Valid;
							wHiData=Hi;
							wLoData=Lo;
						end
					
					`Div,
					`Divu:
						begin
							Hi  = $signed(regaData)  /  $signed(regbData);
							Lo  = $signed(regaData) % $signed(regbData) ;
							whi=`Valid;
							wlo=`Valid;
							wHiData=Hi;
							wLoData=Lo;
						end
					
					`Mfhi:
						regcData=rHiData;
					`Mflo:
						regcData=rLoData;
					`Mthi:
						begin
							whi=`Valid;
							wHiData=regaData;
						end
					`Mthi:
						begin
							wlo=`Valid;
							wLoData=regaData;
						end	
					default:
						begin
							whi=`Invalid;
							wlo=`Invalid;
						end
				endcase
			end

    always@(*)
		begin
			regcWrite = regcWrite_i;
			regcAddr = regcAddr_i;
		end
		
endmodule

