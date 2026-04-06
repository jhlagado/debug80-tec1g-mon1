; TEC-1G LCD test program (MON-1B, app @ 0x0800)
; Purpose: writes a short message to the HD44780 LCD.
;
; Uses: A, HL
; Clobbers: B (in delay)

        .ORG    0x0800

LCD_CMD     EQU     0x04
LCD_DATA    EQU     0x84

START:
        LD      A,0x01          ; clear display
        OUT     (LCD_CMD),A
        CALL    LCD_DELAY

        LD      A,0x80          ; line 1, col 0
        OUT     (LCD_CMD),A
        CALL    LCD_DELAY

        LD      HL,MSG
WRITE_LOOP:
        LD      A,(HL)
        OR      A
        JR      Z,DONE
        OUT     (LCD_DATA),A
        CALL    LCD_DELAY
        INC     HL
        JR      WRITE_LOOP

DONE:
        JP      DONE

LCD_DELAY:
        LD      B,0x40
DELAY_LOOP:
        DJNZ    DELAY_LOOP
        RET

MSG:
        DB      "TEC1G LCD OK",0
