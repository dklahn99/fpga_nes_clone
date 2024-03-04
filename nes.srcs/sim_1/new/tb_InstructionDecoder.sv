`timescale 1ns / 1ps

module tb_InstructionDecoder();

    Instruction instruction;
    logic[2:0] instruction_cycle_count;
    Microcode microcode;
    
    InstructionDecoder instruction_decoder(
        .input_instruction(),
        .input_instruction_cycle_count(),
        .output_microcode(microcode)
    );

    initial begin
    
        // Initialize
        instruction = 8'b000_000_00;
        instruction_cycle_count = 3'b000;
        #10;
        
    end


endmodule
