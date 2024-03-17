`timescale 1ns / 1ps

import Types_6502::*;

module tb_chip_6502();

    logic clk = 0;
    
    // Setup clk
    initial begin
        #10
        forever #10 clk = ~clk;
    end
    
    chip_6502 chip_6502(
        .input_clk(clk)
    );
        
    initial begin
        #50;
    end
    



endmodule
