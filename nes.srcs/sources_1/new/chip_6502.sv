`timescale 1ns / 1ps
`default_nettype none

import Types_6502::*;

module chip_6502(
    inout logic [7:0] inout_data,
    input logic input_clk,
    output logic [15:0] output_addr
);

    Instruction current_instruction = 0;
    InstructionCycle current_instruction_cycle = {0, RISING_EDGE};
    Microcode current_microcode = 0;
    
    logic[7:0] reg_A = 0;
    logic[7:0] reg_X = 0;
    logic[7:0] reg_Y = 0;
    logic[15:0] reg_PC = 0;
    logic[7:0] reg_SP = 0;
    StatusRegister reg_status = 0;
    
    logic[7:0] bus_A = 0;
    logic[7:0] bus_B = 0;

    InstructionDecoder instruc_decoder(
        .input_instruction(current_instruction),
        .input_instruction_cycle(current_instruction_cycle),
        .output_microcode(current_microcode)
    );

    logic[7:0] alu_out_result;
    logic alu_out_carry;
    logic alu_out_overflow;
    ALU alu(
        .input_a(bus_A),
        .input_b(bus_B),
        .input_carry(reg_status.status_named.carry),
        .input_op(current_microcode.alu_op),
        .output_result(alu_out_result),
        .output_carry(alu_out_carry),
        .output_overflow(alu_out_overflow)
    );
    
    always @(input_clk) begin

        // What to do with input data?
        case(current_microcode.data_input_dest)
            DATA_INPUT_DEST_NONE:;
            DATA_INPUT_DEST_INST_BUFFER: current_instruction <= inout_data;
            DATA_INPUT_DEST_PCL: reg_PC[7:0] <= inout_data;
            DATA_INPUT_DEST_PCH: reg_PC[15:0] <= inout_data;
        endcase

        // Load bus A
        case(current_microcode.bus_a_src)
            BUS_A_SRC_A: bus_A = reg_A;
        endcase

        // Load bus B
        case(current_microcode.bus_b_src)
            BUS_B_SRC_A: bus_B = reg_A;
            BUS_B_SRC_DATA_INPUT: bus_B = inout_data;
        endcase

        // Store bus B data
        case(current_microcode.bus_b_dest)
            BUS_B_DEST_NONE:;
            BUS_B_DEST_A: reg_A <= bus_B;
        endcase

        output_addr <= reg_PC;
        
        // Set the next cycle info
        if(input_clk) begin
            current_instruction_cycle.cycle_edge <= FALLING_EDGE;
        end else begin
            reg_PC <= reg_PC + 1;
    
            // Set the next cycle info
            current_instruction_cycle.cycle <= current_instruction_cycle.cycle + 1;
            current_instruction_cycle.cycle_edge <= RISING_EDGE;
        end
    end
    
endmodule
