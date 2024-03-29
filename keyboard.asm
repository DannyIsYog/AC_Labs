BUFFER      EQU     100H    ; endereco de memoria onde se guarda a tecla
PININ       EQU     0E000H  
PINPOUT     EQU     0C000H   ; endereco do porto de E/S do teclado

PLACE       0
inicio:
; inicializacoes gerais
MOV R5, BUFFER      ; R5 com endereco de memoria BUFFER
MOV R9, PINPOUT     ; R2 com o endereco do periferico
MOV R10, PININ
MOV R3, 8           ; R3 com 8 para comparar com a linha atual durante a leitura

; R1 Linha
; R2 Coluna
; R3 8, para comparar
; R5 Buffer para escrever na memoria
; R7 Contador
; R8 4 para multiplicar e temporaria depois
; R9 PINOUT
; R10 PININ
; corpo principal do programa
reset: 
    MOV R1, 1           ; linha a testar
ciclo: 
    MOVB [R9], R1       ; escrever no porto de saida
    MOVB R2, [R10]      ; ler do porto de entrada
    AND R2, R2          ; afectar as flags (MOVs nao afectam as flags)
    JNZ guardar         ; uma tecla foi premida, logo temos de guardar o seu valor
    SHL R1, 1           ; avancar para a proxima linha
    CMP R1, R3          ; se R1 for maior que 8,
    JGT reset           ; reiniciar o R1
    JMP ciclo           ; ou recomecar o ciclo
    
    guardar: 
        MOV R7, 0       ; iniciar um contador em R7
    
        contar:         ; contar o numero de vezes que se pode fazer SHR (log2)
            ADD R7, 1
            SHR R2, 1
            JNZ contar
        SUB R7, 1       ; limitar R7 em [0,3] em vez de [1,4]

        MOVB [R5], R7   ; guardar o numero da coluna na memoria
        MOV R7, 0       ; reiniciar o contador
        
        contar2:        ; contar o numero de vezes que se pode fazer SHR (log2)
            ADD R7, 1
            SHR R1, 1
            JNZ contar2
        SUB R7, 1       ; limitar R7 em [0,3] em vez de [1,4]
        
        MOV R8, 4       ; colocar 4 em R8 para fazer multiplicacao
        MUL R7, R8      ; multiplicar o numero da linha por 4
        MOVB R8, [R5]   ; ler o numero da linha para R8
        ADD R8, R7      ; n=4*L+C  L-linha  C-coluna
        MOVB [R5], R8   ; guardar na memoria o numero lido
        JMP reset       ; repetir ciclo de leitura do teclado

