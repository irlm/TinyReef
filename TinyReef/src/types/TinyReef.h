/*									
 *
 * Copyright (c) 2009-2010 The Regents of the Federal University of Pernambuco.  
 * All rights reserved.
 *
 *
 */

/**
 * TinyReef.h
 *
 * @author Igor L Marques
 * @data Jan 28, 2009.
 * 
 */

#ifndef TINYREEF_H
#define TINYREEF_H

// 2 k bytes 
#define TINYREEF_PROGRAM_SEG_SIZE 2048

enum registersName
{
	R_ZERO = 0, //Always has the value 0. Any writes to this register are ignored.
	R_AT,		//Assembler temporary.
	R_V0,		//Function result registers.
	R_V1,		//	v0 and v1 can be temporary registers. Not preserved across function calls.
	R_A0,		//a0-a3 Function argument registers that hold the first four words of integer type arguments. 
	R_A1,		//	Functions use a0-a1 for the first double precision floating-point argument, and a2-a3 to hold the second double precision floating-point argument.
	R_A2,		//	Not preserved across function calls.
	R_A3,
	R_T0,		//t0-t9 Temporary registers you can use as you want. Not preserved across function calls.
	R_T1,
	R_T2,
	R_T3,
	R_T4,
	R_T5,
	R_T6,
	R_T7,
	R_S0,		//s0-s7 Saved registers to use freely.
	R_S1,		//Preserved across function calls. These registers must be saved before use by the called function.
	R_S2,
	R_S3,
	R_S4,
	R_S5,
	R_S6,
	R_S7,
	R_T8,
	R_T9,
	R_K0,		//k0-k1 Reserved for use by the operating system kernel and for exception return.
	R_K1,
	R_GP,		//Global pointer. 
	R_SP,		//Stack pointer.
	R_FP,		//Frame pointer. or S8 (Saved registers to use freely.)
	R_RA,		//Return address register, saved by the calling function. Available for use after saving.
	SR_HI,		//special registers Lo and Hi used to store result of multiplication and division
	SR_LO,		//not directly addressable; contents accessed with special instruction mfhi ("move from Hi") and mflo ("move from Lo")
	TINYREEF_REGISTERS_NAME_LENGTH
};

typedef struct tinyReefContext
{
    // Program Counter - byte addressing
    uint32_t PC;
	
	//Describes what is currently happening to the process	
	uint8_t state;
	
	int16_t Offset;
	
	uint8_t Memory[TINYREEF_PROGRAM_SEG_SIZE];
	
	//32 Registers
	uint32_t registerFile[TINYREEF_REGISTERS_NAME_LENGTH];
	    
} tinyReefContext_t;


enum tinyReefOpcode
{
	OP_R_TYPE		= 0x00,
	
	OP_I_TYPE_EXT	= 0x01,
	
//Control Flow Instructions
    //jmp Label
    OP_JMP			= 0x02,
    //jal Label
    OP_JAL			= 0x03,

//Control Flow Instructions    
    //Beq Rs, Rt, Label
    OP_BEQ			= 0x04,
    //bne Rs, Rt, Label
    OP_BNE			= 0x05,
    //blez Rs, Label
    OP_BLEZ			= 0x06,
    //bgtz Rs, Label
    OP_BGTZ			= 0x07,

//Arithmetic and Logic Instructions
	//addi Rt, Rs, Imm
    OP_ADD_I		= 0x08,
    //addiu Rt, Rs, Imm
    OP_ADD_I_U		= 0x09,
    
//Data Movement Instructions
	//slti Rt, Rs, Imm
	OP_SLTI			= 0x0A,
	//sltiu Rt, Rs, Imm
	OP_SLTI_U		= 0x0B,

//Arithmetic and Logic Instructions
    //andi Rt, Rs, Imm
    OP_AND_I		= 0x0C,
	//ori Rt, Rs, Imm
	OP_OR_I			= 0x0D,
	//xori Rt, Rs, Imm
	OP_XOR_I		= 0x0E,
	
	//lui Rt, Imm
	OP_LUI			= 0x0F,
	
	//lb Rt, offset(Rs)
    OP_LB			= 0x20,
    //lh Rt, offset(Rs)
    OP_LH			= 0x21,
    //lwl Rt, offset(Rs)
    OP_LWL			= 0x22,
    //lw Rt, offset(Rs)
    OP_LW			= 0x23,
    //lbu Rt, offset(Rs)
    OP_LB_U			= 0x24,
    //lhu Rt, offset(Rs)
    OP_LH_U			= 0x25,
   	//lwr Rt, offset(Rs) 
    OP_LWR			= 0x26,
    //sb Rt, offset(Rs)
    OP_SB			= 0x28,
    //sh Rt, offset(Rs)
    OP_SH			= 0x29,
    //swl Rt, offset(Rs)
    OP_SWL			= 0x2A,
    //sw Rt, offset(Rs)
    OP_SW			= 0x2B,
    //swr Rt, offset(Rs)
    OP_SWR			= 0x2E
};

enum tinyReefInstructionRType
{
//Arithmetic and Logic Instructions
	//sll Rd, Rt, sa
	RT_SLL		= 0x00,
	//srl Rd, Rt, sa
	RT_SRL		= 0x02,
	//sra Rd, Rt, sa
	RT_SRA		= 0x03,
	//sllv Rd, Rt, Rs
	RT_SLLV		= 0x04,
	//srlv Rd, Rt, Rs
	RT_SRLV		= 0x06,
	//srav Rd, Rt, Rs
	RT_SRAV		= 0x07,
	
//Control Flow Instructions
	//jr Rs
	RT_JMP_R	= 0x08,
	//jalr Rd, Rs
	RT_JAL_R	= 0x09,
	
//syscall
	//syscall
	RT_SYSCALL	= 0x0C,
	
//Data Movement Instructions
	//mfhi Rd
	RT_MFHI		= 0x10,
	//mthi Rs
	RT_MTHI		= 0x11,
	//mflo Rd
	RT_MFLO		= 0x12,
	//mtlo Rs
	RT_MTLO		= 0x13,
	
//Arithmetic and Logic Instructions
	//mult Rs, Rt
	RT_MULT		= 0x18,
	//multu Rs, Rt
	RT_MULT_U	= 0x19,
	//div Rs, Rt
	RT_DIV		= 0x1A,
	//divu Rs, Rt
	RT_DIV_U	= 0x1B,		
	//add Rd, Rs, Rt
	RT_ADD 		= 0x20,
	//addu Rd, Rs, Rt
	RT_ADD_U 	= 0x21,
	//sub Rd, Rs, Rt
	RT_SUB 		= 0x22,
	//subu Rd, Rs, Rt
	RT_SUB_U	= 0x23,
	//and Rd, Rs, Rt
	RT_AND		= 0x24,
	//or Rd, Rs, Rt
	RT_OR		= 0x25,
	//xor Rd, Rs, Rt
	RT_XOR		= 0x26,
	//nor Rd, Rs, Rt
	RT_NOR		= 0x27,
	//slt Rd, Rs, Rt
	RT_SLT		= 0x2A,
	//sltu Rd, Rs, Rt
	RT_SLT_U	= 0x2B
		
};

enum tinyReefITypeExtension
{
//Control Flow Instructions
	//bltz Rs, Label
	ITEX_BLTZ		=	0x00,
	//bgez Rs, Label	
	ITEX_BGEZ		=	0x01,
	//bltzal Rs, Label
	ITEX_BLTZAL	=	0x10,
	//bgezal Rs, Label
	ITEX_BGEZAL	=	0x11
};

enum tinyReefSyscall
{
//default
	SYSCALL_PRINT_INT		= 0x01,		//Print an Integer 1 $a0 = Integer Value to be Printed
	SYSCALL_PRINT_FLOAT		= 0x02,		//Print Float 2
	SYSCALL_PRINT_DOUBLE	= 0x03,		//Print Double 3
	SYSCALL_PRINT_STRING	= 0x04,		//Print String 4 $a0 = Address of String in Memory
	SYSCALL_READ_INT		= 0x05,		//Read an Integer in 5 Integer Returned in $v0 (from the keyboard)
	SYSCALL_READ_FLOAT		= 0x06,		//Read Float 6
	SYSCALL_READ_DOUBLE		= 0x07,		//Read Double 7
	SYSCALL_READ_STRING		= 0x08,		//Read a String in 8 $a0 = Address of Input Buffer in Memory (from the keyboard) $a1 = Length of Buffer (n)
	SYSCALL_SBRK			= 0x09,		//Sbrk 9 $a0 = amount Address in $v0
	SYSCALL_EXIT			= 0x0A,		//Exit 10
	
//custom	
	SYSCALL_RECEIVE			= 0x0B,
	SYSCALL_SEND			= 0x0C,
	SYSCALL_SENSE			= 0x0D,
	SYSCALL_SET_LED			= 0x0E,
	SYSCALL_TIMER			= 0x0F,
	SYSCALL_TOGGLE_LED		= 0x10,
	SYSCALL_SET_LED_STATE	= 0x11
};

enum Led_State_enum
{
	LED_OFF = 0,
	LED_ON = 1
};

#endif TINYREEF_H
