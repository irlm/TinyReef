#ifndef TINY_REEF_PROCESS_STATE_H
#define TINY_REEF_PROCESS_STATE_H

typedef enum tinyReefProcessStates
{
	NEW					= 0, 	//Processo recém criado (sendo preparado).
	READY				= 1, 	//Processo sendo carregado.
	STANDBY				= 2, 	//Cada processador tem um processo em standby (o próximo a ser executado).
	RUNNING				= 4, 	//O processo esta rodando (ativo).
	BLOCKED				= 8, 	//Esperando evento externo (inativo).
	SUSPENDED_BLOCKED	= 16, 	//Processo suspenso.
	ZOOMBIED			= 32, 	//O processo acabou mas não informou seu pai.
	DONE_TERMINATED		= 64 	//O processo foi encerrado e os recursos liberados.
}tinyReefProcessStates_t;


#endif /* TINY_REEF_PROCESS_STATE_H */
