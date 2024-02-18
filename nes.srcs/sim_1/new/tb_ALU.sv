`timescale 1ns / 1ps

import Types_6502::*;

`define assert_outputs(RESULT, CARRY, OVERFLOW) \
    assert (alu_out_result == RESULT) else $error("Incorrect alu_out_result at %s line %d", `__FILE__, `__LINE__); \
    assert (alu_out_carry == CARRY) else $error("Incorrect alu_out_carry at %s line %d", `__FILE__, `__LINE__); \
    assert (alu_out_overflow == OVERFLOW) else $error("Incorrect alu_out_overflow at %s line %d", `__FILE__, `__LINE__);

module tb_ALU();

    logic[7:0] alu_in_a;
    logic[7:0] alu_in_b;
    logic alu_in_carry;
    ALUOp alu_in_op;

    logic[7:0] alu_out_result;
    logic alu_out_carry;
    logic alu_out_overflow;
    
    ALU alu(
        .input_a(alu_in_a),
        .input_b(alu_in_b),
        .input_carry(alu_in_carry),
        .input_op(alu_in_op),
        
        .output_result(alu_out_result),
        .output_carry(alu_out_carry),
        .output_overflow(alu_out_overflow)
    );

    initial begin

        // Initialize
        alu_in_a = 0;
        alu_in_b = 0;
        alu_in_carry = 0;
        alu_in_op = ALUOP_ADC;
        #5
        `assert_outputs(0, 0, 0);
        
        // Test ADC
        alu_in_a = 8'b0111_1010;
        alu_in_b = 8'b1111_1101;
        alu_in_carry = 0;
        alu_in_op = ALUOP_ADC;
        #5
        `assert_outputs(8'b0111_0111, 1, 0);
        
        // Test ADC
        alu_in_a = 8'b0111_1111;
        alu_in_b = 8'b0000_0001;
        alu_in_carry = 0;
        alu_in_op = ALUOP_ADC;
        #5
        `assert_outputs(8'b1000_0000, 0, 1);
        
        // Test ADC
        alu_in_a = 8'b1000_0000;
        alu_in_b = 8'b1111_1110;
        alu_in_carry = 1;
        alu_in_op = ALUOP_ADC;
        #5
        `assert_outputs(8'b0111_1111, 1, 1);
        
        // Test SBC
        alu_in_a = 8'b0000_0101;
        alu_in_b = 8'b0000_0011;
        alu_in_carry = 1;
        alu_in_op = ALUOP_SBC;
        #5
        `assert_outputs(8'b0000_0010, 1, 0);
        
        // Test SBC
        alu_in_a = 8'b0000_0101;
        alu_in_b = 8'b0000_0110;
        alu_in_carry = 1;
        alu_in_op = ALUOP_SBC;
        #5
        `assert_outputs(8'b1111_1111, 0, 0);
        
        // Test SBC
        alu_in_a = 8'b1000_0000;
        alu_in_b = 8'b0000_0001;
        alu_in_carry = 1;
        alu_in_op = ALUOP_SBC;
        #5
        `assert_outputs(8'b01111111, 1, 1);
        
        // Test SBC
        alu_in_a = 8'b0111_1111;
        alu_in_b = 8'b1111_1111;
        alu_in_carry = 1;
        alu_in_op = ALUOP_SBC;
        #5
        `assert_outputs(8'b1000_0000, 0, 1);

        // Test AND
        alu_in_a = 8'b1010_1010;
        alu_in_b = 8'b1100_0011;
        alu_in_carry = 0;
        alu_in_op = ALUOP_AND;
        #5
        `assert_outputs(8'b1000_0010, 0, 0);
        
        // Test OR
        alu_in_a = 8'b1010_1010;
        alu_in_b = 8'b1100_0011;
        alu_in_carry = 0;
        alu_in_op = ALUOP_OR;
        #5
        `assert_outputs(8'b1110_1011, 0, 0);
        
        // Test XOR
        alu_in_a = 8'b1010_1010;
        alu_in_b = 8'b1100_0011;
        alu_in_carry = 0;
        alu_in_op = ALUOP_XOR;
        #5
        `assert_outputs(8'b0110_1001, 0, 0);
        
        // Test SHIFT_L
        alu_in_a = 8'b1010_1010;
        alu_in_b = 0;
        alu_in_carry = 0;
        alu_in_op = ALUOP_SHIFT_L;
        #5
        `assert_outputs(8'b0101_0100, 1, 0);
        
        // Test SHIFT_L
        alu_in_a = 8'b0010_1010;
        alu_in_b = 0;
        alu_in_carry = 0;
        alu_in_op = ALUOP_SHIFT_L;
        #5
        `assert_outputs(8'b0101_0100, 0, 0);
        
        // Test SHIFT_R
        alu_in_a = 8'b1010_1011;
        alu_in_b = 0;
        alu_in_carry = 0;
        alu_in_op = ALUOP_SHIFT_R;
        #5
        `assert_outputs(8'b0101_0101, 1, 0);
        
        // Test SHIFT_R
        alu_in_a = 8'b1010_1010;
        alu_in_b = 0;
        alu_in_carry = 0;
        alu_in_op = ALUOP_SHIFT_R;
        #5
        `assert_outputs(8'b0101_0101, 0, 0);

        // Test ROT_L
        alu_in_a = 8'b1010_1010;
        alu_in_b = 0;
        alu_in_carry = 0;
        alu_in_op = ALUOP_ROT_L;
        #5
        `assert_outputs(8'b0101_0100, 1, 0);
        
        // Test ROT_L
        alu_in_a = 8'b0010_1010;
        alu_in_b = 0;
        alu_in_carry = 1;
        alu_in_op = ALUOP_ROT_L;
        #5
        `assert_outputs(8'b0101_0101, 0, 0);
        
        // Test ROT_R
        alu_in_a = 8'b1010_1011;
        alu_in_b = 0;
        alu_in_carry = 0;
        alu_in_op = ALUOP_ROT_R;
        #5
        `assert_outputs(8'b0101_0101, 1, 0);
        
        // Test ROT_R
        alu_in_a = 8'b1010_1010;
        alu_in_b = 0;
        alu_in_carry = 1;
        alu_in_op = ALUOP_ROT_R;
        #5
        `assert_outputs(8'b1101_0101, 0, 0);
        

    end


endmodule
