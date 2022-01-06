.386
DATA SEGMENT USE16
BUF     DB 100, 0, 100 DUP(0)
DATA ENDS

STACK SEGMENT USE16 STACK
        DW 100 DUP(0)
STACK ENDS

CODE SEGMENT USE16
        ASSUME CS:CODE, SS:STACK, DS:DATA
START:  MOV AX, DATA
        MOV DS, AX
        MOV AX, STACK
        MOV SS, AX
        LEA DX, BUF
        MOV AH, 10
        INT 21H
        MOV BL, BUF+1
        MOV BH, 0
        MOV BYTE PTR BUF+2[BX], '$'
        OUTPUT BUF+2
        CALL FBTS
        OUTPUT BUF+2
        MOV AH, 4CH
        INT 21H
FBTS PROC
        PUSHA
        PUSHF
        LEA SI, BUF+2
LOOPA:  MOV AL, BYTE PTR [SI]
        CMP AL, '$'
        JE EXIT
        CMP AL, 'a'
        JB NEXT
        CMP AL, 'z'
        JA NEXT
        SUB AL, 60H
        ADD AL, 40H
        MOV BYTE PTR DS:[SI], AL
NEXT:   INC SI
        JMP LOOPA
EXIT:   POPF
        POPA
        RET
FBTS ENDP
OUTPUT MACRO TOOUT
        PUSH DX
        PUSH AX
        LEA DX, TOOUT
        MOV AH, 9
        INT 21H
        POP AX
        POP DX
        ENDM 
CODE ENDS
        END START

