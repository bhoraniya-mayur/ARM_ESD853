;Circular Queue in Assembly
;This will Enqueue to fill whole queue, 
;then dequeue 2 elements and then enqueue 
;then dequeue and then enqueue
		PRESERVE8
		THUMB
		AREA Arm_ASM,CODE,READONLY
		ENTRY
		EXPORT __main
			
			
SIZE EQU 40				;40 BYTES
START EQU 0				; start = front = rear
ADDR  EQU 0x20000000	;Address of queue	

__main FUNCTION
		MOV R0,#SIZE				;Queue Size
		MOV R1, #START			; Queue rear
			
		MOV R3, #ADDR	;Queue start Adddress in Memory
		MOV R4, #START		;Queue front


loop			;check queue legth
		BLGT  enqueue				;call enqueue
		CMP R0,#0
		BGT loop				;continue if queue is not empty
		
		BL dequeue				; dequeue
		BL dequeue				;dequeue
		BL enqueue				;enqueue
		BL enqueue
		BL dequeue
		BL enqueue
		
stop 	B stop

enqueue
		CMP R0,#0			; checck if queue is full
		BXEQ LR			;cannot enqueue
		ADD R5, #2			;Take a value in R5
		STR R5,[R3,R1]		;Store in Memory
		;ADD R3, #0X04		;Increment memory
		ADD R1,#4		;increment rear
		CMP R1,#SIZE
		MOVEQ R1,#START
		SUB R0,R0,#4		;decrement queue size
		BX	LR		
		
dequeue
		CMP R0,#SIZE		;if queue is empty
		BXEQ LR 				;cannot dequeue
		LDR R6, [R3,R4]		;take from memory
		ADD R4, #0x04		;increment front
		ADD R0,#4			;Increment queue size
		CMP R4,#SIZE		;if rear == size, 	
		MOVEQ R4,#START		;==>queue is full, start from start
		
			
		
		BX  LR
		ENDFUNC
		END
			
