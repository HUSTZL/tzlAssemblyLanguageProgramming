.386
DATA SEGMENT USE16
BUF     DB 10,0,10 DUP(0)
OUT     DB 10 DUP(0)
READ    DW 0
DATA ENDS

STACK SEGMENT USE16
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
        CALL F16T10
        LEA DX, OUT
        MOV AH, 9
        INT 21H
        MOV AH, 4CH
        INT 21H

F16T10  PROC
        PUSHA
        PUSHF
        MOV BL, BUF+1
        MOV BH, 0
        MOV SI, 0
        MOV CX, BX
  s



