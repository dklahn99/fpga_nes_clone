`timescale 1ns / 1ps
`default_nettype none

import Types_6502::*;

module tb_InstructionDecoder();

    Instruction instruction;
    InstructionCycle instruction_cycle;
    Microcode microcode;
    
    InstructionDecoder instruction_decoder(
        .input_instruction(instruction),
        .input_instruction_cycle(instruction_cycle),
        .output_microcode(microcode)
    );

    initial begin
    
        // Initialize
        instruction = 8'b000_000_00;
        instruction_cycle = {0, RISING_EDGE};
        
        // ADC #immediate Instruction
        instruction = 8'b011_010_01;
        #20


        for (int i=0; i<12; i=i+1) begin
            
            if(instruction_cycle.cycle_edge == RISING_EDGE) begin
                instruction_cycle.cycle_edge <= FALLING_EDGE;
            end else begin
                instruction_cycle.cycle += 1;
                instruction_cycle.cycle_edge <= RISING_EDGE;
            end


            #10;
        end
        
    end


endmodule
