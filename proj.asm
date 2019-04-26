;*******************************************************************************
;* Projeto 1 de Arquitetura de Computadores, LETI                              *
;* 93577 - Fabio Sousa                                                         *
;* 93587 - Joao Pereira                                                        *
;* 93608 - Pedro Godinho                                                       *
;*                                                                             *
;* Controlos:                                                                  *
;* 0, 1, 2, 4, 6, 8, 9, A - Movimento do Submarino                             *
;* F - Restart                                                                 *
;*******************************************************************************

DISPLAY     EQU     8000H       ; Endereco do display
KEYPININ    EQU     0E000H      ; Endereco de onde ler do keyboard
KEYPINOUT   EQU     0C000H      ; Endereco de onde escrever para o keyboard


PLACE 1000H
stack:  TABLE 100H ; Stack vai ter 100H words

SP_start:

; Tabela do movimento ao qual cada tecla corresponde (2, 2 indica nao mover)
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

; uma tabela dos numeros binarios 1000 0000 a 0000 0001 (one-hot)
onehot_table:   WORD 80H
                WORD 40H
                WORD 20H
                WORD 10H
                WORD 8H
                WORD 4H
                WORD 2H
                WORD 1H


;*******************************************************************************
;* Cada string que se pode desenhar no ecra comeca com o x e o y onde devem    *
;* ser desenhadas, seguidos do seu tamanho em x e em y (para a rotina saber    *
;* onde para a leitura), seguido dos 0s e 1s a desenhar em cada posicao.       *
;*******************************************************************************

; Ecra "Press any key" a mostrar no inicio do jogo
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

; Desenho do submarino
submarine:  STRING 0CH, 12H
            STRING 6, 3
            STRING 0, 0, 1, 1, 0, 0
            STRING 0, 0, 0, 1, 0, 0
            STRING 1, 1, 1, 1, 1, 1

; Retangulo de 0s do tamanho do submarino, mantido sincroniado com o submarino para o apagar sempre que necessario
erase_submarine:    STRING 0CH, 12H
                    STRING 6, 3
                    STRING 0, 0, 0, 0, 0, 0
                    STRING 0, 0, 0, 0, 0, 0
                    STRING 0, 0, 0, 0, 0, 0


; Ultima tecla lida
last_key:   word -1

; Comecar o programa
PLACE 0    

restart:
    MOV SP, SP_start ; (Re)iniciar o stack

    ;Reiniciar a last_key para -1
    MOV R0, last_key
    MOV R1, -1
    MOV [R0], R1 

    ; Reiniciar o sitio do submarino
    MOV R0, submarine
    MOV R1, erase_submarine
    MOV R2, 0CH     ; x para 0CH
    MOVB [R0], R2
    MOVB [R1], R2

    MOV R2, 12H     ; y para 12H
    ADD R0, 1       ; avancar o endereco para y
    ADD R1, 1       ; avancar o endereco para y
    MOVB [R0], R2
    MOVB [R1], R2

    ; Reiniciar os registos
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

    ; Mostrar o ecra inicial
    MOV R0, start_screen
    CALL draw_string

    MOV R0, last_key    ; R0 - endereco da last_key

    restart_wait:
        CALL get_key
        MOV R1, [R0]    ; ler a ultima tecla carregada
        CMP R1, -1
        JEQ restart_wait    ; Se nenhuma tecla foi carregada, continuar a esperar

; Comecar o jogo: 
call clear_screen   ; Limpar o ecra

; Desenho inicial de cada elemento no ecra
MOV R0, submarine
CALL draw_string

main_loop:
    CALL handle_input   ; ler input
    JMP main_loop       ; recomecar o main_loop

end: JMP end

; Rotina que apaga tudo no ecra (da esquerda para a direita, para ser diferente)
clear_screen:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3

    MOV R3, 0 ; Queremos sempre desenhar um 0
    MOV R0, 20H ; R0: 20H, para comparacoes

    MOV R1, 0 ; R1: x
    clear_screen_for1: ;for (x = 0; x < 20H, x++) {
        CMP R1, R0
        JGE clear_screen_for1_end

        MOV R2, 0 ; R2: y
        clear_screen_for2: ;   for (y = 0; y < 20H, y++) {
            CMP R2, R0
            JGE clear_screen_for2_end

            CALL draw_pixel ; R1 e R2 ja tem as coordenadas a desenhar

            ADD R2, 1 ; fim do loop interno
            JMP clear_screen_for2
        clear_screen_for2_end:

        ADD R1, 1 ; fim do loop externo
        JMP clear_screen_for1
    clear_screen_for1_end:

    clear_screen_end:
        POP R3
        POP R2
        POP R1
        POP R0
        RET


; Funcao que gere o input do programa.
handle_input:
    PUSH R0
    PUSH R1

    CALL get_key                ; gravar tecla lida para last_key

    MOV R1, last_key
    MOV R0, [R1]                ; valor de last_key para R0

    CMP R0, -1
    JEQ handle_input_no_input   ; nao foi dado input

    MOV R1, 0AH
    CMP R0, R1
    JLE handle_input_movement   ; o input e uma das teclas de movimento (menor que AH)

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
        JMP handle_input_no_input
    handle_input_restart:       ; reiniciar
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
    ADD R4, 1               ; Avancar para o y na tabela de movimentos
    MOVB R6, [R4]           ; R6 - movimento y a fazer

    MOV R7, 0
    MOV R8, 0

    MOVB R7, [R1]
    ADD R7, R5              ; R7 - x final
    
    ADD R1, 1
    MOVB R8, [R1]
    ADD R8, R6              ; R8 - y final
    MOV R1, submarine

    MOV R3, 00FFH           ; Mask para 8 bits
    AND R7, R3              ; Aplicar a mask em R7 e R8
    AND R8, R3

    MOV R3, 1BH             ; R3: 1BH (20H - tamanho em x do submarino)
    MOV R4, 1EH             ; R4: 1EH (20H - tamanho em y do submarino)

    CMP R5, 2               ; Consideramos 2 no movimento como indicativo de movimento nulo
    JEQ handle_movement_end

    ; Verificar se o movimento e valido
    AND R7, R7              ; Se o x ficaria negativo (fora do ecra a esquerda)
    JN handle_movement_end
    CMP R7, R3              ; Se o x + tamanho do submarino ficaria acima de 20H (fora do ecra a direita)
    JGE handle_movement_end
    AND R8, R8              ; Se o y ficaria negativo (fora do ecra para cima)
    JN handle_movement_end
    CMP R8, R4              ; Se o y + tamanho do submarino ficaria acima de 20H (fora do ecra para baixo)
    JGE handle_movement_end

    ; Se o movimento e valido:
    MOV R0, erase_submarine
    CALL draw_string        ; apagar o submarino

    MOVB [R1], R7           ; Fazer o movimento em x em submarine
    MOVB [R2], R7           ; Fazer o movimento em x em erase_submarine

    ADD R1, 1               ; Avancar para y
    ADD R2, 1               ; Avancar para y

    MOVB [R1], R8           ; Fazer o movimento em y em submarine
    MOVB [R2], R8           ; Fazer o movimento em y em erase_submarine

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

    ; Obter o bit a desenhar (por exemplo, 0010 0000  para desenhar o terceiro pixel de um grupo)
    MOV R4, onehot_table    ; Endereco da lista de onehots
    MOV R6, 2               ; Para a multiplicacao
    MUL R1, R6              ; Multiplicar o x por 2, para ver o indice na lista
    ADD R4, R1              ; Adicionar o indice na lista ao endereco na lista
    MOV R4, [R4]            ; E ler para R4

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
        SUB R5, 1 ; numero de vezes que podemos fazer SHL a R4

        MOV R0, R5 ; guardar no return (R0)

        MOV R5, 0 ; outro contador a 0
        get_key_count2:
            ADD R5, 1
            SHR R3, 1
            JNZ get_key_count2
        SUB R5, 1 ; numero de vezes que podemos fazer SHL a R3

        MOV R1, 4           ; reutilizar um registo ja nao usado para a multiplicacao
        MUL R5, R1          ; linha*4+coluna
        ADD R0, R5
        JMP get_key_end
    
    get_key_return_null:    ; nenhuma tecla carregada, return -1
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
