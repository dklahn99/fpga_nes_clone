`timescale 1ns / 1ps

import Types_6502::*;

module ALU(
    input logic input_a[7:0],
    input logic input_b[7:0],
    input logic input_carry,
    input ALUOp input_op,
    
    output logic output_result[7:0],
    output logic output_carry,
    output logic output_overflow
);

//typedef enum {
//    ALUOP_ADC,
//    ALUOP_SUB,
//    ALUOP_AND,
//    ALUOP_OR,
//    ALUOP_XOR,
//    ALUOP_SHIFT_L,
//    ALUOP_SHIFT_R,
//    ALUOP_ROT_L,
//    ALUOP_ROT_R
//} ALUOp;

    // TODO: overflow

    always_comb begin
    
        case (input_op)
            ALUOP_ADC: begin
                {output_carry, output_result} = input_a + input_b;
            end
            
            ALUOP_SUB: begin
                {output_carry, output_result} = input_a - input_b;
            end
            
            ALUOP_AND: begin
                output_result = input_a & input_b;
            end
            
            ALUOP_OR: begin
                output_result = input_a | input_b;
            end
            
            ALUOP_XOR: begin
                output_result = input_a ^ input_b;
            end
            
            ALUOP_SHIFT_L: begin
                output_result = {input_a[6:0], 1b'0};
                output_carry = input_a[7];
            end
            
            ALUOP_SHIFT_R: begin
                output_result = {1b'0, input_a[7:1]};
                output_carry = input_a[0];
            end
            
            ALUOP_ROT_L: begin
                output_result = {input_a[6:0], input_carry};
                output_carry = input_a[7];
            end
            
            ALUOP_ROT_R: begin
                output_result = {input_carry, input_a[7:1]};
                output_carry = input_a[0];
            end
        endcase
    end
    
endmodule
