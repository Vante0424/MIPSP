
`include "define.v"
module  ID (
    input wire rst,
	//指令数据
    input wire [31:0] inst,
    input wire [31:0] regaData_i,
    input wire [31:0] regbData_i,
	
	  input wire[31:0] pc,
	
	//操作码
    output reg [5:0] op,
	  output reg [4:0] regaAddr,
    output reg [4:0] regbAddr, 
    output reg [31:0] regaData,
    output reg [31:0] regbData,
	  output reg [4:0] regcAddr,
    output reg regaRead,
    output reg regbRead,
    output reg regcWrite,
	
	  output reg[31:0] jAddr,
	  output reg jCe
);
    wire [5:0] Inst_op = inst[31:26];
    reg [31:0] imm;
    wire[5:0] func = inst[5:0];

	  wire[31:0]npc = pc+4;
	
    always@(*)
        if(rst == `RstEnable)
          begin
            op = ` nop;
            regaRead = `Invalid;
            regbRead = `Invalid;
            regcWrite = `Invalid;
            regaAddr = `Zero;
            regbAddr = `Zero;
            regcAddr = `Zero;
            imm    = `Zero;			
			      jCe=`Invalid;
			      jAddr=`Zero;
          end
       else
          begin        
			      jCe=`Invalid;
			      jAddr=`Zero;
            case(Inst_op)
               ` Inst_addi:
                  begin
                    op = ` Add;
                    regaRead = `Valid;
                    regbRead = `Invalid;
                    regcWrite = `Valid;
                    regaAddr = inst[25:21];
                    regbAddr = `Zero;
                    regcAddr = inst[20:16];
                    imm = {16'h0, inst[15:0]};
                  end
                  
                ` Inst_andi:
                  begin
                    op = ` And;
                    regaRead = `Valid;
                    regbRead = `Invalid;
                    regcWrite = `Valid;
                    regaAddr = inst[25:21];
                    regbAddr = `Zero;
                    regcAddr = inst[20:16];
                    imm = {16'h0, inst[15:0]};
                  end
                
                ` Inst_ori:
                  begin
                    op = ` Or;
                    regaRead = `Valid;
                    regbRead = `Invalid;
                    regcWrite = `Valid;
                    regaAddr = inst[25:21];
                    regbAddr = `Zero;
                    regcAddr = inst[20:16];
                    imm = {16'h0, inst[15:0]};
                  end
                  
                ` Inst_xori:
                  begin
                    op = ` Xor;
                    regaRead = `Valid;
                    regbRead = `Invalid;
                    regcWrite = `Valid;
                    regaAddr = inst[25:21];
                    regbAddr = `Zero;
                    regcAddr = inst[20:16];
                    imm = {16'h0, inst[15:0]};
                  end
                
                ` Inst_beq:
                  begin
                    op = ` nop;
                    regaRead = `Valid;
                    regbRead = `Valid;
                    regcWrite = `Invalid;
                    regaAddr = inst[25:21];
                    regbAddr = inst[20:16];
                    regcAddr = `Invalid;
                    jAddr = npc + {{14{inst[15]}},inst[15:0],2'b00};
					          imm = `Zero;
					          if(regaData == regbData)
					            jCe = `Valid;
                  end
                  
                ` Inst_bne:
                  begin
                    op = ` nop;
                    regaRead = `Valid;
                    regbRead = `Valid;
                    regcWrite = `Invalid;
                    regaAddr = inst[25:21];
                    regbAddr = inst[20:16];
                    regcAddr = `Invalid;
                    jAddr = npc + {{14{inst[15]}},inst[15:0],2'b00};
					          imm = `Zero;
					          if(regaData != regbData)
					            jCe = `Valid;
                  end
                  
                ` Inst_lui:
                  begin
                    op = ` Jal;
                    regaRead = `Invalid;
                    regbRead = `Invalid;
                    regcWrite = `Valid;
                    regaAddr = `Zero;
                    regbAddr = `Zero;
                    regcAddr = inst[20:16];
                    imm = {inst[15:0],16'h0};
                  end
                
                `Inst_lw:
                  begin
		                op = `Lw;
		                regaRead = `Valid;
		                regbRead = `Invalid;
		                regcWrite = `Valid;
		                regaAddr = inst[25:21];
		                regbAddr = `Zero;
		                regcAddr = inst[20:16];
		                imm = {{16{inst[15]}},inst[15:0]};
		                regaData = regaData_i + imm;
		             end
		             
		            `Inst_sw:
		              begin
		                op = `Sw;
	                  regaRead = `Valid;
		                regbRead = `Valid;
		                regcWrite = `Invalid;
		                regaAddr = inst[25:21];
		                regbAddr = inst[20:16];
		                regcAddr = `Zero;
		                imm = {{16{inst[15]}},inst[15:0]};
		                regaData = regaData_i + imm;
		             end
		             
		             //12
		            ` Inst_bgtz:
                  begin
                    op = ` nop;
                    regaRead = `Valid;
                    regbRead = `Invalid;
                    regcWrite = `Invalid;
                    regaAddr = inst[25:21];
                    regbAddr = `Zero;
                    regcAddr = `Zero;
                    jAddr = npc + {{14{inst[15]}},inst[15:0],2'b00};
					          imm = `Zero;
					          if(regaData > 0)
					            jCe = `Valid;
                  end
                
                ` Inst_bltz:
                  begin
                    op = ` nop;
                    regaRead = `Valid;
                    regbRead = `Invalid;
                    regcWrite = `Invalid;
                    regaAddr = inst[25:21];
                    regbAddr = `Zero;
                    regcAddr = `Zero;
                    jAddr = npc + {{14{inst[15]}},inst[15:0],2'b00};
					          imm = `Zero;
					          if(regaData < 0)
					            jCe = `Valid;
                  end


                  
                ` Inst_r:
                     case(func)
                       `Inst_add:
                          begin
                            op = `Add;
                            regaRead = `Valid;
                            regbRead = `Valid;
                            regcWrite = `Valid;
                            regaAddr = inst[25:21];
                            regbAddr = inst[20:16];
                            regcAddr = inst[15:11];
                            imm = `Zero;
                          end
                       `Inst_sub:
                          begin
                            op = `Sub;
                            regaRead = `Valid;
                            regbRead = `Valid;
                            regcWrite = `Valid;
                            regaAddr = inst[25:21];
                            regbAddr = inst[20:16];
                            regcAddr = inst[15:11];
                            imm = `Zero;
                          end
                       `Inst_and:
                          begin
                            op = `And;
                            regaRead = `Valid;
                            regbRead = `Valid;
                            regcWrite = `Valid;
                            regaAddr = inst[25:21];
                            regbAddr = inst[20:16];
                            regcAddr = inst[15:11];
                            imm = `Zero;
                          end
                       `Inst_or:
                          begin
                            op = `Or;
                            regaRead = `Valid;
                            regbRead = `Valid;
                            regcWrite = `Valid;
                            regaAddr = inst[25:21];
                            regbAddr = inst[20:16];
                            regcAddr = inst[15:11];
                            imm = `Zero;
                          end
                       `Inst_xor:
                          begin
                            op = `Xor;
                            regaRead = `Valid;
                            regbRead = `Valid;
                            regcWrite = `Valid;
                            regaAddr = inst[25:21];
                            regbAddr = inst[20:16];
                            regcAddr = inst[15:11];
                            imm = `Zero;
                          end
                       `Inst_sll:
                          begin
                            op = `Sll;
                            regaRead = `Invalid;
                            regbRead = `Valid;
                            regcWrite = `Valid;
                            regaAddr = `Zero;
                            regbAddr = inst[20:16];
                            regcAddr = inst[15:11];
                            imm = {27'h0, inst[10:6]};
                          end
                       `Inst_srl:
                          begin
                            op = `Srl;
                            regaRead = `Invalid;
                            regbRead = `Valid;
                            regcWrite = `Valid;
                            regaAddr = `Zero;
                            regbAddr = inst[20:16];
                            regcAddr = inst[15:11];
                            imm = {27'h0, inst[10:6]};
                          end
                       `Inst_sra:
                          begin
                            op = `Sra;
                            regaRead = `Invalid;
                            regbRead = `Valid;
                            regcWrite = `Valid;
                            regaAddr = `Zero;
                            regbAddr = inst[20:16];
                            regcAddr = inst[15:11];
                            imm = {27'h0, inst[10:6]};
                          end
                       `Inst_jr:
                          begin
			                      op = ` nop;
                            regaRead = `Valid;
                            regbRead = `Invalid;
                            regcWrite = `Invalid;
                            regaAddr = inst[25:21];
                            regbAddr = `Zero;
                            regcAddr = `Zero;
							              jAddr = regaData_i;
							              jCe = `Valid;
                            imm = `Zero;
                          end
                          
                        //12
                        `Inst_slt:
							begin
								op = ` Slt;
								regaRead = `Valid;
								regbRead = `Valid;
								regcWrite = `Valid;
								regaAddr = inst[25:21];
								regbAddr = inst[20:16];
								regcAddr = inst[15:11];
								imm = `Zero;
							end
                          
                        `Inst_jalr:
                            begin
							   op=`Jal;
							   regaRead = `Invalid;
							   regbRead = `Valid;
							   regcWrite = `Valid;
							   regaAddr = `Zero;
							   regbAddr = inst[25:21];
							   regcAddr = inst[15:11];
							   jAddr = regbData_i;
							   jCe = `Valid;
							   imm = npc;
							end
				                    
				        `Inst_mult:
                            begin
							   op=`Mult;
							   regaRead = `Valid;
							regbRead = `Valid;
							   regcWrite = `Invalid;
							   regaAddr = inst[25:21];
							   regbAddr = inst[20:16];
							   regcAddr = `Zero;
				            end
				                   
				        `Inst_multu:
                            begin
							    op=`Multu;
							    regaRead = `Valid;
								regbRead = `Valid;
							    regcWrite = `Invalid;
							    regaAddr = inst[25:21];
							    regbAddr = inst[20:16];
							    regcAddr = `Zero;
				            end
				                   
				        `Inst_div:
                            begin
							   op=`Div;
							   regaRead = `Valid;
							   regbRead = `Valid;
							   regcWrite = `Invalid;
							   regaAddr = inst[25:21];
							   regbAddr = inst[20:16];
							   regcAddr = `Zero;
				            end
				                   
				        `Inst_divu:
                            begin
							    op=`Divu;
							    regaRead = `Valid;
							    regbRead = `Valid;
							    regcWrite = `Invalid;
							    regaAddr = inst[25:21];
							    regbAddr = inst[20:16];
							    regcAddr = `Zero;
				            end
				                    
                        `Inst_mfhi:
							begin
							    op=`Mfhi;
							    regaRead = `Invalid;
							    regbRead = `Invalid;
							    regcWrite = `Valid;
							    regaAddr = `Zero;
							    regbAddr = `Zero;
							    regcAddr = inst[15:11];
				            end
						`Inst_mflo:
							begin
							    op=`Mflo;
							    regaRead = `Invalid;
							    regbRead = `Invalid;
							    regcWrite = `Valid;
							    regaAddr = `Zero;
							    regbAddr = `Zero;
							    regcAddr = inst[15:11];
				            end
						`Inst_mthi:
							begin
							    op=`Mthi;
							    regaRead = `Valid;
							    regbRead = `Invalid;
							    regcWrite = `Invalid;
							    regaAddr = inst[25:21];
							    regbAddr = `Zero;
							    regcAddr = `Zero;
				            end
						`Inst_mtlo: 
							begin
							    op=`Mtlo;
							    regaRead = `Valid;
							    regbRead = `Invalid;
							    regcWrite = `Invalid;
							    regaAddr = inst[25:21];
							    regbAddr = `Zero;
							    regcAddr = `Zero;
				            end
                        default:
                          begin
                            op = ` nop;
                            regaRead = `Invalid;
                            regbRead = `Invalid;
                            regcWrite = `Invalid;
                            regaAddr = `Zero;
                            regbAddr = `Zero;
                            regcAddr = `Zero;
                            imm = `Zero;
                          end
                    endcase
					
					      `Inst_j:
					          begin
					             op=`nop;
					             regaRead = `Invalid;
                       regbRead = `Invalid;
					             regcWrite = `Invalid;
					             regaAddr = `Zero;
					             regbAddr = `Zero;
					             regcAddr = `Zero;
					             jAddr = {npc[31:28],inst[25:0],2'b00};
					             jCe = `Valid;
					             imm = `Zero;
				            end
					
				        `Inst_jal:
				            begin
					             op=`Jal;
					             regaRead = `Invalid;
                       regbRead = `Invalid;
					             regcWrite = `Valid;
					             regaAddr = `Zero;
					             regbAddr = `Zero;
					             regcAddr = 5'b11111;
					             jAddr = {npc[31:28],inst[25:0],2'b00};
					             jCe = `Valid;
					             imm = npc;
				            end
				            
                default:
                  begin
                    op = ` nop;
                    regaRead = `Invalid;
                    regbRead = `Invalid;
                    regcWrite = `Invalid;
                    regaAddr = `Zero;
                    regbAddr = `Zero;
                    regcAddr = `Zero;
                    imm = `Zero;
                  end
            endcase 
          end

    always@(*)
      if(rst == `RstEnable)
          regaData = `Zero;
      else if(regaRead == `Valid)
          regaData = regaData_i;
      else
          regaData = imm;

    always@(*)
      if(rst == `RstEnable)
          regbData = `Zero;      
      else if(regbRead == `Valid)
          regbData = regbData_i;
      else
          regbData = imm; 
endmodule

