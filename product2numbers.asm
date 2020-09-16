include "emu8086.inc"
; START-OF-PROGRAM
	org 100h
    	jmp RD1  
    
; Memory variables
First	dw	0

prompt1	db	0dh, 0ah,"Enter first integer (-128...127): ",0
prompt2	db	0dh, 0ah,"Enter second integer (-128...127): ",0
product	db	0dh, 0ah,"Product = ",0
interror1	db	0dh, 0ah, "Number is too big!", 0dh, 0ah,0
interror2	db	0dh, 0ah, "Number is too small!", 0dh, 0ah,0
Result  	db	0dh, 0ah, "The product is: ",0

RD1:	lea	SI, prompt1	; Address of prompt1: “Enter first int”
	call	PRINT_STRING ; Print prompt1  
   	call	SCAN_NUM	; Read the first integer into CX 
CMP CX,127			; Is it too big (>127)?
JLE CONT			; Continue to next number if not (CONT:)
CMP CX, -128			; Is it too small (<-128)?
JGE CONT			; Continue to next number if not (CONT:)
LEA SI, INTERROR1			; Address of error message 1
CALL PRINT_STRING			; Print interror1
JMP RD1			; Read again (jump to RD1:)
CONT: MOV FIRST, CX			; Move the first number into ‘First’
RD2: LEA SI, PROMPT2			; Address of prompt2: “Enter second int”
CALL PRINT_STRING			; Print prompt2
CALL SCAN_NUM			; Read the second integer into CX  
CMP CX, 127			; Is it too big (>127)?
JLE CONT2			; Continue to mul if not (CONT2:)
CMP CX, -128			; Is it too small (<-128)?
JGE CONT2			; Continue to mul if not (CONT2:)
LEA SI, INTERROR1			; Address of error message 1
CALL PRINT_STRING			; Print interror1
JMP RD2			; Read again again (jump to RD2:)
CONT2: MOV AX, FIRST		 	; Move the first number into AX
MUL CX			; Multiply
	lea	SI, Result	; Address of string: “The product is”
	call	PRINT_STRING ; Print string
 	CALL	PRINT_NUM	; Print the result
bort:	mov	ax,4c00h	; code for return to ms-dos
	int	21h	; call ms-dos terminate program
	ret

; Macro definitions
DEFINE_PRINT_STRING
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
	end 					;END-OF-PROGRAM
