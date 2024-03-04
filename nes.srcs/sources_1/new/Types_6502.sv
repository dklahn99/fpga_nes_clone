`timescale 1ns / 1ps

package Types_6502;

typedef union packed {
    struct packed {
        logic negative;
        logic overflow;
        logic unused;
        logic b_flag;
        logic decimal;
        logic int_disable;
        logic zero;
        logic carry;
    } status_named;
    logic[7:0] status_byte;
} StatusRegister;

typedef enum {
    TODO
} AddressingMode;

typedef enum logic[3:0] {
    ALUOP_ADC,
    ALUOP_SBC,
    ALUOP_AND,
    ALUOP_OR,
    ALUOP_XOR,
    ALUOP_SHIFT_L,
    ALUOP_SHIFT_R,
    ALUOP_ROT_L,
    ALUOP_ROT_R
} ALUOp;

typedef enum logic[1:0] {
    BUS_A_SRC_A
} BUS_A_SRC;

typedef enum logic[1:0] {
    BUS_B_SRC_A
} BUS_B_SRC;

typedef enum logic[1:0] {
    BUS_A_DEST_A
} BUS_A_DEST;

typedef enum logic[1:0] {
    BUS_B_DEST_A
} BUS_B_DEST;

typedef enum logic[2:0] {
    DATA_INPUT_DEST_BUFFER,
    DATA_INPUT_INST_BUFFER,
    DATA_INPUT_DEST_A,
    DATA_INPUT_DEST_ALU_B,
    DATA_INPUT_DEST_PCL,
    DATA_INPUT_DEST_PCH
} DATA_INPUT_DEST;

typedef struct packed {
    DATA_INPUT_DEST data_input_dest;
    BUS_A_SRC bus_a_src;
    BUS_B_SRC bus_b_src;
    BUS_A_DEST bus_a_dest;
    BUS_B_DEST bus_b_dest;
    ALUOp alu_op;
} Microcode;

typedef logic[7:0] Instruction;

typedef enum logic[2:0] {
    ADC = 3'b011
} OPCODE_GROUP_1;

typedef enum logic[2:0] {
    IMMEDIATE_GROUP_1 = 3'b010
} ADDR_MODE_GROUP_1;

endpackage
