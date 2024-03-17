`timescale 1ns / 1ps
`default_nettype none

import Types_6502::*;

module Group1InstructionDecoder(
    input Instruction input_instruction,
    input InstructionCycle input_instruction_cycle,
    output Microcode output_microcode
);

    OPCODE_GROUP_1 opcode;
    assign opcode = input_instruction[7:5];
    
    ADDR_MODE_GROUP_1 addr_mode;
    assign addr_mode = input_instruction[4:2];
    
    always_comb begin
    
        output_microcode = 0;  // Default values
    
        if (opcode == ADC && addr_mode == IMMEDIATE_GROUP_1) begin
            case(input_instruction_cycle.cycle)
                1: begin
                    output_microcode.data_input_dest = DATA_INPUT_DEST_INST_BUFFER;
                end

                2: begin
                    if (input_instruction_cycle.cycle == RISING_EDGE) begin
                        output_microcode.bus_a_src = BUS_A_SRC_A;
                        output_microcode.bus_b_src = BUS_B_SRC_DATA_INPUT;
                    end else begin
                        output_microcode.bus_b_src = BUS_B_SRC_ALU_OUT;
                        output_microcode.bus_b_dest = BUS_B_DEST_A;
                    end
                end
            endcase
        end
    
    end


endmodule



module InstructionDecoder(
    input Instruction input_instruction,
    input InstructionCycle input_instruction_cycle,
    output Microcode output_microcode
);

    Microcode group1_microcode;
    Group1InstructionDecoder group1_decoder(
        .input_instruction(input_instruction),
        .input_instruction_cycle(input_instruction_cycle),
        .output_microcode(group1_microcode)
    );

    logic[1:0] group;
    assign group = input_instruction[1:0];

    always_comb begin
        case (group)
            2'b01: begin
                output_microcode = group1_microcode;
            end
            
            default: begin
                output_microcode = 0;
            end
        endcase
        
        // All instructions have the same opcode fetch sequence at the beginning
        if (input_instruction_cycle.cycle == 0 && input_instruction_cycle.cycle_edge == RISING_EDGE) begin
            output_microcode = {
                data_input_dest:(DATA_INPUT_DEST_INST_BUFFER),
                default: 0
            };
        end else if (input_instruction_cycle.cycle == 0 && input_instruction_cycle.cycle_edge == FALLING_EDGE) begin
            output_microcode = {
                data_input_dest:(DATA_INPUT_DEST_INST_BUFFER),
                default: 0
            };
        end
    end

endmodule
