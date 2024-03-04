`timescale 1ns / 1ps

import Types_6502::*;

module chip_6502(
    logic [15:0] in_addr,
    logic [7:0] inout_data,
    logic in_clk
);

    Instruction current_instruction;
    logic[2:0] current_instruction_cycle_count;
    Microcode current_microcode;
    
    logic reg_A[7:0];
    logic reg_X[7:0];
    logic reg_Y[7:0];
    logic reg_PC[15:0];
    logic reg_SP[7:0];
    StatusBits reg_status[7:0];
    
    logic bus_A[7:0];
    logic bus_B[7:0];
    
    always_ff @(posedge in_clk) begin
    
    end
    
    always_ff @(negedge in_clk) begin
    
    end
    
    
    
    
endmodule
