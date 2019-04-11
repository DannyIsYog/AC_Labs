DISPLAY     EQU     8000H
KEYPININ    EQU     0E000H
KEYPINOUT   EQU     0C000H

; Stack começa a 1000H
PLACE 1000H
stack:  TABLE 100H ; Stack vai ter 100H words

SP_start:

movement:   STRING -1, -1   ; 0
            STRING 0, -1    ; 1
            STRING 1, -1    ; 2
            STRING 2, 2     ; 3
            STRING -1, 0    ; 4
            STRING 2, 2     ; 5
            STRING 1, 0     ; 6
            STRING 2, 2     ; 7
            STRING -1, 1    ; 8
            STRING 0, 1     ; 9
            STRING 1, 1     ; a

start_screen:   STRING 0H, 0H
                STRING 20H, 20H
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
                STRING 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


clear_screen:   STRING 0H, 0H
                STRING 20H, 20H
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                STRING 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0


submarine:  STRING 0CH, 12H         ; Coordenadas onde desenhar
            STRING 6, 3             ; Tamanho (x, y) da string
            STRING 0, 0, 1, 1, 0, 0
            STRING 0, 0, 0, 1, 0, 0
            STRING 1, 1, 1, 1, 1, 1

erase_submarine:    STRING 0CH, 12H
                    STRING 6, 3
                    STRING 0, 0, 0, 0, 0, 0
                    STRING 0, 0, 0, 0, 0, 0
                    STRING 0, 0, 0, 0, 0, 0

last_key:   word -1

; Comecar o programa
PLACE 0

program_start: 
    MOV SP, SP_start ; Iniciar o stack

restart:
    MOV R0, last_key
    MOV R1, -1
    MOV [R0], R1 


    MOV R0, submarine
    MOV R1, erase_submarine
    MOV R2, 0CH
    MOVB [R0], R2
    MOVB [R1], R2
    MOV R2, 12H
    ADD R0, 1
    ADD R1, 1
    MOVB [R0], R2
    MOVB [R1], R2

    MOV R0, 0
    MOV R1, 0
    MOV R2, 0
    MOV R3, 0
    MOV R4, 0
    MOV R5, 0
    MOV R6, 0
    MOV R7, 0
    MOV R8, 0
    MOV R10, 0

    MOV R0, start_screen
    CALL draw_string
    MOV R0, last_key

    restart_wait:
        CALL get_key
        MOV R1, [R0]
        CMP R1, -1
        JEQ restart_wait

MOV R0, clear_screen
call draw_string

main_loop:
    MOV R0, submarine
    CALL draw_string
    ; ler input
    CALL handle_input

    JMP main_loop

end: JMP end


; Funcao que gere o input do programa.
handle_input:
    PUSH R0
    PUSH R1

    CALL get_key                ; gravar tecla lida para R0

    MOV R1, last_key
    MOV R0, [R1]

    CMP R0, -1
    JEQ handle_input_no_input   ; nao foi dado input

    MOV R1, 0AH
    CMP R0, R1
    JLE handle_input_movement   ; o input e uma das teclas de movimento

    MOV R1, 0EH
    CMP R0, R1
    JEQ handle_input_stop       ; o input e a tecla de stop (e)

    MOV R1, 0FH
    CMP R0, R1
    JEQ handle_input_restart    ; o input e a tecla de restart (f)


    JMP handle_input_end


    handle_input_movement:      ; fazer o movimento em R0 e acabar
        CALL handle_movement
        JMP handle_input_end

    handle_input_stop:          ; TODO
    handle_input_restart:
        JMP restart
    
    handle_input_no_input:

    handle_input_end:
        POP R1
        POP R0
        RET


; Funcao que move o submarino e o desenha no fim
; Args: R0 - Tecla
handle_movement:
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

    MOV R1, submarine       ; R1 - endereco do submarino
    MOV R2, erase_submarine ; R2 - endereco do erase_submarine

    MOV R4, last_key
    MOV R3, [R4]            ; R3 - last_key
    MOV R4, 2
    MUL R3, R4              ; R3 - last_key * 2

    MOV R4, movement        ; R4 - endereco da tabela de movimentos
    ADD R4, R3              ; R4 - endereco do movimento a fazer

    MOVB R5, [R4]           ; R5 - movimento x a fazer
    ADD R4, 1
    MOVB R6, [R4]           ; R6 - movimento y a fazer

    MOV R7, 0
    MOV R8, 0

    MOVB R7, [R1]
    ADD R7, R5              ; R7 - x final
    
    ADD R1, 1
    MOVB R8, [R1]
    ADD R8, R6              ; R8 - y final
    MOV R1, submarine

    MOV R3, 00FFH
    AND R7, R3
    AND R8, R3

    MOV R3, 1BH
    MOV R4, 1EH

    CMP R5, 2
    JEQ handle_movement_end

    AND R7, R7
    JN handle_movement_end
    CMP R7, R3
    JGE handle_movement_end
    AND R8, R8
    JN handle_movement_end
    CMP R8, R4
    JGE handle_movement_end


    MOV R0, erase_submarine
    CALL draw_string        ; apagar o submarino

    MOVB [R1], R7
    MOVB [R2], R7

    ADD R1, 1
    ADD R2, 1

    MOVB [R1], R8
    MOVB [R2], R8

    MOV R0, submarine
    CALL draw_string        ; Desenhar de novo o submarino

    handle_movement_end:
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


; Funcao que desenha uma string no ecra
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
            ADD R0, 1       ; Avancar para o proximo pixel


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


; Funcao que desenha um determinado pixel no ecra
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

; Funcao que le do teclado
; Returns:  last_key:  -1 se nenhuma, a tecla se alguma
get_key:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6

    MOV R1, KEYPININ    ; R1: endereco in do periferico
    MOV R2, KEYPINOUT   ; R2: endereco out do periferico
    MOV R3, 1           ; R3: linha atual
    MOV R6, 8           ; R6: constante para comparar
    get_key_cicle:
        MOVB [R2], R3       ; Escrever a linha no out
        MOVB R4, [R1]       ; R4: Coluna (ler a coluna do in)
        AND R4, R4          ; Atualizar bits de estado
        JNZ get_key_save    ; Guardar a tecla encontrada
        SHL R3, 1
        CMP R3, R6
        JGT get_key_return_null ; Percorremos todas as linhas
        JMP get_key_cicle

    get_key_save:
        MOV R5, 0 ; iniciar um contador a 0
        get_key_count1:
            ADD R5, 1
            SHR R4, 1
            JNZ get_key_count1
        SUB R5, 1

        MOV R0, R5 ; guardar no return (R0)

        MOV R5, 0 ; outro contador a 0
        get_key_count2:
            ADD R5, 1
            SHR R3, 1
            JNZ get_key_count2
        SUB R5, 1

        MOV R1, 4 ; reutilizar um registo ja nao usado para a multiplicacao
        MUL R5, R1
        ADD R0, R5
        JMP get_key_end
    
    get_key_return_null:
        MOV R0, -1
    get_key_end:
        MOV R1, last_key
        MOV [R1], R0
        POP R6
        POP R5
        POP R4
        POP R3
        POP R2
        POP R1
        POP R0
        RET
