`timescale 1ns / 1ps

import Types_6502::*;

module ALU(
    input logic[7:0] input_a,
    input logic[7:0] input_b,
    input logic input_carry,
    input ALUOp input_op,
    
    output logic[7:0] output_result,
    output logic output_carry,
    output logic output_overflow
);

    // Define adder circuit to be used for addition and subtraction operations
    logic adder_input_carry;
    logic[7:0] adder_input_a;
    logic[7:0] adder_input_b;
    logic[8:0] adder_output;
    logic adder_overflow;
    assign adder_output = adder_input_a + adder_input_b + adder_input_carry;
    assign adder_overflow = (adder_output[7] ^ adder_input_a[7]) & (adder_output[7] ^ adder_input_b[7]);
    // Overflow occurs if two positive numbers result in a negative number, or
    // two negative numbers result in a positive number
    // Referenced https://www.righto.com/2012/12/the-6502-overflow-flag-explained.html
    
    always_comb begin
    
        case (input_op)
            ALUOP_ADC: begin
                adder_input_a = input_a;
                adder_input_b = input_b;
                adder_input_carry = input_carry;
            
                output_result = adder_output[7:0];
                output_carry = adder_output[8];
                output_overflow = adder_overflow;
            end
            
            ALUOP_SBC: begin
                adder_input_a = input_a;
                adder_input_b = ~input_b;
                adder_input_carry = input_carry;
                
                output_result = adder_output[7:0];
                output_carry = adder_output[8];
                output_overflow = adder_overflow;
            end
            
            ALUOP_AND: begin
                output_result = input_a & input_b;
                output_carry = 0;
                output_overflow = 0;
            end
            
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
