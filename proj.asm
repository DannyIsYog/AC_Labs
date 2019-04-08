DISPLAY     EQU     8000H

; Stack começa a 1000H
PLACE 1000H
stack:  TABLE 100H ; Stack vai ter 100H words

SP_start:

submarine:  STRING 27H, 17H         ; Coordenadas onde desenhar
            STRING 6, 3             ; Tamanho (x, y) da string
            STRING 0, 0, 1, 1, 0, 0
            STRING 0, 0, 0, 1, 0, 0
            STRING 1, 1, 1, 1, 1, 1

erase_submarine:    STRING 27H, 17H
                    STRING 6, 3
                    STRING 0, 0, 0, 0, 0, 0
                    STRING 0, 0, 0, 0, 0, 0
                    STRING 0, 0, 0, 0, 0, 0

; Comecar o programa
PLACE 0

start: 
    MOV SP, SP_start ; Iniciar o stack

    MOV R0, submarine
    CALL draw_string
    MOV R0, erase_submarine
    CALL draw_string
    JMP start


end: JMP end

; Args: R0 - String
draw_string:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R8
    PUSH R9

    MOVB R4, [R0]   ; R4: canto superior esquerdo do desenho (x)
    ADD R0, 1
    MOVB R5, [R0]   ; R5: canto superior esquerdo do desenho (y)
    ADD R0, 1
    MOVB R6, [R0]   ; R6: tamanho do x do desenho
    ADD R0, 1
    MOVB R7, [R0]   ; R7: tamanho do y do desenho
    ADD R0, 1       ; Colocar R0 no endereco do primeiro pixel a desenhar

    MOV R9, 0       ; R9: Contador do y atual (i)

    draw_string_y:      ; for (i = 0; i < tamanho_y; i++)
        CMP R9, R7
        JGE draw_string_y_end
        
        MOV R8, 0       ; R8: Contador do x atual (j)
        draw_string_x:  ; for (j = 0; j < tamanho_x; j++)
            CMP R8, R6
            JGE draw_string_x_end
            
            MOV R1, R8      ; Copia do x atual
            ADD R1, R4      ; Adicionar o canto para ver o x onde escrever
            MOV R2, R9      ; Copia do y atual
            ADD R2, R5      ; Adicionar o canto para ver o y onde escrever
            MOVB R3, [R0]   ; Ler o pixel a desenhar
            CALL draw_pixel ; Desenhar o pixel em questao (R1, R2 e R3 ja tem os args)
            ADD R0, 1   ; Avancar para o proximo pixel


            ADD R8, 1
            JMP draw_string_x
        draw_string_x_end:

        ADD R9, 1
        JMP draw_string_y
    draw_string_y_end:

    POP R9
    POP R8
    POP R7
    POP R6
    POP R5
    POP R4
    POP R3
    POP R2
    POP R1
    POP R0
    RET


; Args: R1 - x
;       R2 - y
;       R3 - 1 ou 0 (escrever ou apagar)
draw_pixel:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6

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
    draw_cont:      ; Contamos os SHR que conseguimos faer a R4 (linha%4)
        SUB R1, 1
        CMP R1, 0
        JLT draw_draw
        SHR R4, 1
        JMP draw_cont
    draw_draw:
        MOVB R5, [R0]   ; Ler o que ja estava no display nesse grupo de pixeis
        AND R3, R3      ; Atualizar bits de estado para R3
        JZ draw_0
        draw_1:
            OR R5, R4   ; Colocar o pixel no sitio
            JMP draw_apply
        draw_0:
            NOT R4      ; Negar R4 para apagar
            AND R5, R4  ; Colorcar o pixel no sitio
        draw_apply:
            MOVB [R0], R5   ; Desenhar o grupo de novo

    draw_end:
        POP R6
        POP R5
        POP R4
        POP R3
        POP R2
        POP R1
        POP R0
        RET

get_key:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R8
    PUSH R9

    

    POP R9
    POP R8
    POP R7
    POP R6
    POP R5
    POP R4
    POP R3
    POP R2
    POP R1
    POP R0
