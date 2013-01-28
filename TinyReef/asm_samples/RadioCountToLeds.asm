//RadioCountToLeds

//global initialization...
//TODO verificar o mov para a memoria das variaveis antes de colocar nos registradores....
movc 	$0	250			//timer
movc 	$1 	"fire"
movc	$2	"receive"
movc	$3	0			//count
movc	$4	0			//led
//events...
timer	0	$0	$1
//procedures...
fire:
addc	$3	1
//TODO colocar o valor do count
//TODO montar o pacote???
//TODO send packet...
receive:
//TODO get counter..
movmr "counter addr"


 mov    DWORD PTR [ebp-8], 1
    mov    eax, DWORD PTR [ebp-8]
    and    eax, 1
    cmp    eax, DWORD PTR [ebp-8]
    jne    .L2
    mov    DWORD PTR [ebp-8], 2
    jmp    .L3
.L2:
    mov    DWORD PTR [ebp-8], 3
.L3:


	cmp	$3, 1
	jne	.L2
	movc	$4	0//TODO led0Off();
	led		$4	0 0 //padding padding
	jmp	.L4
.L2:
	mov	DWORD PTR [ebp-8], 3
.L4:

//TODO if (rcm->counter & 0x1) {
movc	$4	0//TODO led0On();
led		$4	0 0 //padding padding
//TODO       } else {

//TODO      }


//TODO if (rcm->counter & 0x2) {
movc	$4	0//TODO led1On();
led		$4	0 0 //padding padding
//TODO 		 } else {
movc	$4	0//TODO led1Off();
led		$4	0 0 //padding padding
//TODO      }
//TODO if (rcm->counter & 0x4) {
 movc	$4	0//TODO led2On();
led		$4	0 0 //padding padding
//TODO 	 }  else {
 movc	$4	0//TODO led2Off();
led		$4	0 0 //padding padding
//TODO      }

	cmp	DWORD PTR [ebp-8], 1
	jne	.L2
	mov	DWORD PTR [ebp-8], 2
	jmp	.L4
.L2:
	mov	DWORD PTR [ebp-8], 3
.L4:

//TODO.....
tinyReefInstruction_t program[] = {
	  		{OP_MOV_CONST,     0, 0x03, 0xE8},	// mov $0 1000
	  		{OP_MOV_CONST,     1, 0, 4},		// mov $1 4
	  		{OP_RECEIVE,       1, 0, 5},		// receive 0 $0 $1
	  		{OP_TIMER,         0, 0, 5},		// timer 0 $0 $1
	  		{OP_HALT,          0, 0, 0},		// halt
	  		{OP_MOV_MEM_RES,   0, 0, 0},		// mov #0 $0
	  		{OP_ADD_CONST,     0, 0, 1},		// add $0 1
	  		{OP_MOV_RES_MEM,   0, 0, 0},		// mov $0 #0
	  		{OP_SEND,		   0xff, 0xff, 0},
	  		{OP_LED,           0, 0, 0},		// led $0
	  		{OP_HALT,          0, 0, 0}			// halt
	  	};
