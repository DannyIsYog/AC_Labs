PLACE 1000H
stack:  TABLE 100H ; Stack vai ter 100H words

SP_start:

ex_tab: word int0

PLACE 0

program_start: 
    MOV SP, SP_start ; Iniciar o stack
    MOV BTE, ex_tab

int0:
    PUSH R1
    MOV R1, 7H
    POP R1
    RFE