DISPLAY     EQU     8000H

; Stack começa a 1000H
PLACE 1000H
stack:  TABLE 100H

SP_start:

PLACE 0

start: MOV SP, SP_start
    MOV R1, 27  ;coluna
    MOV R2, 21  ;linha
    MOV R3, 1
    CALL x_y

    MOV R1, 12  ;coluna
    MOV R2, 13  ;linha
    MOV R3, 1
    CALL x_y

    MOV R1, 27  ;coluna
    MOV R2, 21  ;linha
    MOV R3, 0
    CALL x_y

end: JMP end

; Assume R1 x (coluna)
; Assume R2 y (linha)
; Assume R3 1 ou 0 (escrever ou apagar)
x_y:
    PUSH R1         ; Guardar R1
    PUSH R2         ; Guardar R2
    PUSH R3         ; Guardar R3
    AND R1, R1
    JZ end_x_y
    MOV R0, DISPLAY ; Endereco base
    MOV R6, 8       ; Usado para operacoes
    MOV R4, R1      ; Criar uma copia de R2
    DIV R4, R6      ; Dividir Coluna por 8
    ADD R0, R4      ; Somar isso ao endereco
    MOD R1, R6      ; Modulo da coluna por 8, para saber onde estamos a contar do inicio do grupo

    MOV R6, 4       ; Para multiplicacoes
    MUL R2, R6      ; Multiplicar a linha por 4 (grupos por linha)
    ADD R0, R2      ; Somar ao endereco

    MOV R4, 80H     ; Comecar por 1000 000
    x_y_cont:       ; Contamos os SHR que conseguimos faer a R4 (linha%4)
        SUB R1, 1
        CMP R1, 0
        JLT x_y_draw
        SHR R4, 1
        JMP x_y_cont
    x_y_draw:
        MOVB R5, [R0]   ; Ler o que ja estava no display nesse grupo de pixeis
        AND R3, R3      ; Atualizar bits de estado para R3
        JZ x_y_0
        x_y_1:
            OR R5, R4   ; Colocar o pixel no sitio
            JMP x_y_apply
        x_y_0:
            NOT R4      ; Negar R4 para apagar
            AND R5, R4  ; Colorcar o pixel no sitio
        x_y_apply:
            MOVB [R0], R5   ; Desenhar o grupo de novo
    end_x_y:
        POP R3          ; Restaurar R3
        POP R2          ; Restaurar R2
        POP R1          ; Restaurar R1
        RET
