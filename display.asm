DISPLAY     EQU     8000H

MOV R1, 0  ;linha
MOV R2, 0  ;coluna

; Assume R1 linha
; Assume R2 coluna
draw_pixel:
    MOV R0, DISPLAY ; Endereco base
    MOV R3, 8       ; Usado para operacoes
    MOV R4, R2      ; Criar uma copia de R2
    DIV R4, R3      ; Dividir Coluna por 8
    ADD R0, R4      ; Somar isso ao endereco
    MOD R2, R3      ; Modulo da coluna por 8, para saber onde estamos a contar do inicio do grupo

    MOV R3, 4       ; Para multiplicacoes
    MUL R1, R3      ; Multiplicar a linha por 4 (grupos por linha)
    ADD R0, R1      ; Somar ao endereco

    MOV R4, 80H     ; Comecar por 1000 000
    cont:               ; Contamos os SHR que conseguimos faer a R4 (linha%4)
        SUB R2, 1
        CMP R2, 0
        JLT draw
        SHR R4, 1
        JMP cont
    draw:
        MOVB R5, [R0]   ; Ler o que ja estava no display nesse grupo de pixeis
        OR R4, R5       ; Colocar o pixel a desenhar no sitio no grupo
        ; Mudando isto para XOR podemos fazer toggle de um pixel
        MOVB [R0], R4   ; Desenhar o grupo de novo

fim: JMP fim
