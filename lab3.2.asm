
BUFFER	EQU	100H	; endereco de memoria onde se guarda a tecla
LINHA	EQU	8	; posicao do bit correspondente a linha (4) a testar
PINPOUT	EQU	8000H	; endereco do porto de E/S do teclado

PLACE		0
inicio:
; inicializacoes gerais
  MOV 	R5, BUFFER	; R5 com endereco de memoria BUFFER
	MOV	R1, 1	; linha a testar
	MOV	R2, PINPOUT	; R2 com o endereco do periferico
  MOV R6, 8
; corpo principal do programa
ciclo:	MOVB 	[R2], R1	; escrever no porto de saida
	MOVB 	R3, [R2]	; ler do porto de entrada
	AND 	R3, R3		; afectar as flags (MOVs nao afectam as flags)
	JNZ 	guardar		; nenhuma tecla premida
  SHL   R1, 1
  CMP   R1, R6     ; se R1 nao corresponde a uma linha valida...
  JGT   reset     ; reiniciar o R1
  JMP ciclo       ; recomecar o ciclo
reset:  MOV   R1, 1
  JMP   ciclo     ; e recomecar o ciclo
guardar:	MOV	R4, R3		; guardar coluna premida em registo 4
  MOV R7, 0
contar:
    ADD R7, 1
    SHR R4, 1
    JNZ contar
  SUB R7, 1
  MOVB  [R5], R7
  MOV R4, R1 ; guardar linha premida em registo 4
  MOV R7, 0
contar2:
    ADD R7, 1
    SHR R4, 1
    JNZ contar2
  SUB R7, 1
  MOV R8, 4
  MUL R7, R8
  MOV R8, [R5]
  ADD R8, R7
  MOVB [R5], R8
  MOV R8, [R5]
  MOV   R1, 1
	JMP 	ciclo		; repetir ciclo
