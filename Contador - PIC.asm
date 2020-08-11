;************************************************************ 
; Processor: PIC16F628 at 4 MHz using internal RC oscillator 
; Function:  0 to 9 Display 
; Hardware:  Testboard K4 
; Filename:  628LED.asm 
; Author:    Lars Petersen, oz1bxm@pobox.com 
; Website:   www.qsl.net/oz1bxm/PIC/pic.htm 
; Credit:    Tony Nixon's LED flasher 
;************************************************************ 

        ;Para indicar ao compilador qual o microcontrolador utilizado usa-se o LIST
        ;R=DEC diz que o sistema de numera??o ? decimal
        ;Todo coment?rio ? entendido pelo ;
        ;Assembly n?o ? case sensitive
        
        LIST P=16F628A, R=DEC    ; Use the PIC16F628 and decimal system 

        ;O include pode ser entre "" ou <> . Usamos este recurso para incluir uma biblioteca no projeto/c?digo
        
        #include <P16F628A.INC>  ; Include header file 

        ;CONFIGURA??O DO MODO DE FUNCIONAMENTO (FUSE BITS)
        __config  _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF & _PWRTE_ON & _BODEN_ON 
        
        ;O que essas coisas significam?
        ;_INTRC_OSC_NOCLKOUT - o PIC utilizar? o oscilador interno de 4 MHz, o que garante que cada ciclo de m?quina tenha 1 ?s de dura??o.
        ;_LVP_OFF ? para definir a voltagem (5V)
        ;_WDT_OFF - desliga o Watchdog timer.
        ;_PWRTE_ON - ? um timer de 72ms que faz o microcontrolador aguardar at? que tudo esteja estabilizado
        ;_BODEN_ON se ligado o PIC resetar? se a tens?o de alimenta??o cair para menos do que 4V durante 100?s. 

        CBLOCK 0x20             ; Declare variable addresses starting at 0x20
          Loop1,Loop2 
        ENDC 
; 
; ----------- 
; INITIALIZE 
; ----------- 
; 
        ORG    0x000           ; Program starts at 0x000 
 
        ;CLRF torna n?vel baixo a porta
        CLRF   PORTA           ; Initialize port A
                
        CLRF   PORTB           ; Initialize port B 
 
        
        BSF    STATUS,RP0      ; RAM bank 1
        ;Seleciona banco 1 porque o TRISA e TRISB estao nele
 
        CLRF   TRISA           ; All pins port A output 
        CLRF   TRISB           ; All pins port B output 

        BCF    STATUS,RP0      ; RAM bank 0 
; 
; ------------------------ 
; FUNCTION OF PORT A PINS 
; ------------------------ 
;       Desativa comparador de tens?o, CODIGO 7
        MOVLW    7 
        MOVWF    CMCON         ; Comparators off, all pins digital I/O 
; 
; ---------- 
; MAIN LOOP 
; ---------- 
; 
Main    BSF     PORTB, 1       
        BSF     PORTB, 2
        BSF     PORTB, 3
        BSF     PORTB, 5
        BSF     PORTB, 6
        BSF     PORTB, 7
        CALL    delay 
        BCF     PORTB, 1       
        BCF     PORTB, 2
        BCF     PORTB, 3
        BCF     PORTB, 5
        BCF     PORTB, 6
        BCF     PORTB, 7

        BSF     PORTB, 3
        BSF     PORTB, 5
        CALL    delay
        BCF     PORTB, 3
        BCF     PORTB, 5
        
        BSF     PORTB, 2
        BSF     PORTB, 3
        BSF     PORTB, 0
        BSF     PORTB, 7
        BSF     PORTB, 6
        CALL    delay
        BCF     PORTB, 2
        BCF     PORTB, 3
        BCF     PORTB, 0
        BCF     PORTB, 7
        BCF     PORTB, 6
        
        BSF     PORTB, 2
        BSF     PORTB, 3
        BSF     PORTB, 0
        BSF     PORTB, 5
        BSF     PORTB, 6
        CALL    delay
        BCF     PORTB, 2
        BCF     PORTB, 3
        BCF     PORTB, 0
        BCF     PORTB, 5
        BCF     PORTB, 6
        
        BSF     PORTB, 1
        BSF     PORTB, 0
        BSF     PORTB, 3
        BSF     PORTB, 5
        CALL    delay
        BCF     PORTB, 1
        BCF     PORTB, 0
        BCF     PORTB, 3
        BCF     PORTB, 5
        
        BSF     PORTB, 2
        BSF     PORTB, 1
        BSF     PORTB, 0
        BSF     PORTB, 5
        BSF     PORTB, 6
        CALL    delay
        BCF     PORTB, 2
        BCF     PORTB, 1
        BCF     PORTB, 0
        BCF     PORTB, 5
        BCF     PORTB, 6
        
        BSF     PORTB, 2
        BSF     PORTB, 1
        BSF     PORTB, 0
        BSF     PORTB, 7
        BSF     PORTB, 6
        BSF     PORTB, 5
        CALL    delay
        BCF     PORTB, 2
        BCF     PORTB, 1
        BCF     PORTB, 0
        BCF     PORTB, 7
        BCF     PORTB, 6
        BCF     PORTB, 5
        
        BSF     PORTB, 2
        BSF     PORTB, 3
        BSF     PORTB, 5
        CALL    delay
        BCF     PORTB, 2
        BCF     PORTB, 3
        BCF     PORTB, 5
        
        BSF     PORTB, 0
        BSF     PORTB, 1
        BSF     PORTB, 2
        BSF     PORTB, 3
        BSF     PORTB, 5
        BSF     PORTB, 6
        BSF     PORTB, 7
        CALL    delay
        BCF     PORTB, 0
        BCF     PORTB, 1
        BCF     PORTB, 2
        BCF     PORTB, 3
        BCF     PORTB, 5
        BCF     PORTB, 6
        BCF     PORTB, 7
        
        BSF     PORTB, 0
        BSF     PORTB, 1
        BSF     PORTB, 2
        BSF     PORTB, 3
        BSF     PORTB, 5
        CALL    delay
        BCF     PORTB, 0
        BCF     PORTB, 1
        BCF     PORTB, 2
        BCF     PORTB, 3
        BCF     PORTB, 5
        
        GOTO    Main 
; 
; --------------- 
; DELAY 1000 MSEC 
; --------------- 
; 
delay   MOVLW   1000
        MOVWF   Loop1 
Outer   MOVLW   200 
        MOVWF   Loop2 
Inner   NOP 
        NOP 
        DECFSZ  Loop2,F 
        GOTO    Inner          ; Inner loop = 5 usec. 
        DECFSZ  Loop1,F 
        GOTO    Outer 
        RETURN 

        END
 