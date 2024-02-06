`timescale 1ns / 1ps

import Types_6502::*;

module chip_6502(
    logic in_addr[15:0],
    logic inout_data[7:0],
    logic in_clk
);
    
    logic reg_A[7:0];
    logic reg_X[7:0];
    logic reg_Y[7:0];
    logic reg_PC[15:0];
    logic reg_SP[7:0];
    StatusBits reg_status[7:0];
    
    logic bus_A[7:0];
    logic bus_B[7:0];
    
    
endmodule
