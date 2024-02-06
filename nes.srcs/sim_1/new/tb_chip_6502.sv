`timescale 1ns / 1ps

import Types_6502::*;

module tb_chip_6502();

    logic clk;
    
    // Setup clk
    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end


    StatusRegister reg_ST = 0;
//    typedef struct packed {
//        logic carry;
//        logic zero;
//        logic int_disable;
//        logic decimal;
//        logic b_flag;
//        logic unused;
//        logic overflow;
//        logic negative;
//    } StatusBits;
        
    initial begin
        reg_ST.status_struct.carry = 1;
        #15;
        reg_ST.status_struct.zero = 1;
        #15;
        reg_ST.status_struct.int_disable = 1;
        #15;
        reg_ST.status_struct.decimal = 1;
        #15;
        reg_ST.status_struct.b_flag = 1;
        #15;
        reg_ST.status_struct.unused = 1;
        #15;
        reg_ST.status_struct.overflow = 1;
        #15;
        reg_ST.status_struct.negative = 1;
        #15;
        $finish;
    end
    
//    chip_6502(
//        in_clk(clk)
//    );


endmodule
