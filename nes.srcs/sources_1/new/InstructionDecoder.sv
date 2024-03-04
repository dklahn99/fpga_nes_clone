`timescale 1ns / 1ps

import Types_6502::*;

module Group1InstructionDecoder(
    input Instruction input_instruction,
    input logic[2:0] input_instruction_cycle_count,
    output Microcode output_microcode
);

    


endmodule



module InstructionDecoder(
    input Instruction input_instruction,
    input logic[2:0] input_instruction_cycle_count,
    output Microcode output_microcode
);

    Microcode group1_microcode;
    Group1InstructionDecoder group1_decoder(
        .input_instruction(input_instruction),
        .input_instruction_cycle_count(input_instruction_cycle_count),
        .output_microcode(group1_microcode)
    );

    logic[1:0] group = input_instruction[2:0];

    always_comb begin
        case (group)
            2'b01: begin
                output_microcode = group1_microcode;
            end
            
            default: begin
                output_microcode = 0;
            end
        endcase
    end

endmodule
