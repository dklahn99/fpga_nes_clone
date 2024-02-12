`timescale 1ns / 1ps

import Types_6502::*;

module ALU(
    input logic[7:0] input_a,
    input logic[7:0] input_b,
    input logic[7:0] input_carry,
    input ALUOp input_op,
    
    output logic[7:0] output_result,
    output logic output_carry,
    output logic output_overflow
);

    // TODO: overflow

    always_comb begin
    
        logic[8:0] temp_result;
        logic temp_carry;

        case (input_op)
            ALUOP_ADC: begin
                temp_result = input_a + input_b + input_carry;
                output_result = temp_result[7:0];
                output_carry = temp_result[8];
                // Calculate overflow
                // Overflow occurs if two positive numbers result in a negative number, or
                // two negative numbers result in a positive number
                output_overflow = ((input_a[7] == input_b[7]) && (input_a[7] != temp_result[7])) ? 1'b1 : 1'b0;
            end
            
//            ALUOP_SUB: begin
//                {output_carry, output_result} = input_a - input_b;
//            end
            
//            ALUOP_AND: begin
//                output_result = input_a & input_b;
//            end
            
//            ALUOP_OR: begin
//                output_result = input_a | input_b;
//            end
            
//            ALUOP_XOR: begin
//                output_result = input_a ^ input_b;
//            end
            
//            ALUOP_SHIFT_L: begin
//                output_result = {input_a[6:0], 1b'0};
//                output_carry = input_a[7];
//            end
            
//            ALUOP_SHIFT_R: begin
//                output_result = {1b'0, input_a[7:1]};
//                output_carry = input_a[0];
//            end
            
//            ALUOP_ROT_L: begin
//                output_result = {input_a[6:0], input_carry};
//                output_carry = input_a[7];
//            end
            
//            ALUOP_ROT_R: begin
//                output_result = {input_carry, input_a[7:1]};
//                output_carry = input_a[0];
//            end
        endcase
    end
    
endmodule
