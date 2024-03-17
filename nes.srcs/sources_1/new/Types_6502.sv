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
    BUS_B_SRC_A,
    BUS_B_SRC_DATA_INPUT,
    BUS_B_SRC_ALU_OUT
} BUS_B_SRC;

typedef enum logic[1:0] {
    BUS_B_DEST_NONE = 0,
    BUS_B_DEST_A
} BUS_B_DEST;

typedef enum logic[1:0] {
    DATA_INPUT_DEST_NONE = 0,
    DATA_INPUT_DEST_INST_BUFFER,
    DATA_INPUT_DEST_PCL,
    DATA_INPUT_DEST_PCH
} DATA_INPUT_DEST;

typedef struct packed {
    // Data sources
    DATA_INPUT_DEST data_input_dest;
    BUS_A_SRC bus_a_src;
    BUS_B_SRC bus_b_src;
    BUS_B_DEST bus_b_dest;

    // Actions to take
    ALUOp alu_op;
    logic inc_pc;
} Microcode;

typedef enum logic {
    RISING_EDGE,
    FALLING_EDGE
} CYCLE_EDGE;

typedef struct packed {
    logic[2:0] cycle;
    CYCLE_EDGE cycle_edge;
} InstructionCycle;

typedef logic[7:0] Instruction;

typedef enum logic[2:0] {
    ADC = 3'b011
} OPCODE_GROUP_1;

typedef enum logic[2:0] {
    IMMEDIATE_GROUP_1 = 3'b010
} ADDR_MODE_GROUP_1;

endpackage
