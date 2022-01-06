.386
DATA SEGMENT USE16
A       DW      M,1234H
BUF     DB      'AB',0DH, 0AH
M       DB      2 DUP(1), 2 DUP(2 DUP(2), 'B')
T1      DD      F
DATA ENDS

DATA1 SEGMENT USE16
        DW      100 DUP(0)
F       DW      40H
DATA1 ENDS

STACK SEGMENT USE16 STACK
        DW      100 DUP(0)
STACK ENDS

CODE SEGMENT USE16
        ASSUME DS:DATA, SS:STACK, CS: CODE
START:  SHLD AX, BX, 1
        MOV AX, DATA
        MOV DS, AX
        MOV AX, STACK
        MOV SS, AX
        LEA DI, [SI + 4]
		SHLD A, AX, 1
		;SHLD WORD PTR [0], AX, 1
        MOV AX, WORD PTR [0]
		SAL AX, 3
        SHL AX, 4
        SAR AX, 2
        SHR AX, 4
        MOV AX, DATA1
        MOV ES, AX
        MOV AX, ES:F
        MOV A, 123H
        MOV DI, OFFSET [SI+4] ;出错了，本质上相当于MOV DI, [SI + 4]
        MOV AL, 40H + 70H
        MOV AX, BUF-2
        ASSUME DS:DATA1
        LDS SI, T1
        MOV AX, 1 LT 2
        MOV AL, A
        MOV DX, BUF
        MOV AL, M
        MOV BUF, AL
        MOV AH, 4CH
        INT 21
CODE ENDS
        END START
