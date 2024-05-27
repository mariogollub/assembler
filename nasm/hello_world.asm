[BITS 16]               ; 16 bit Code Generierung
[ORG 0x7C00]            ; Ursprung

; Main (Hauptprogramm)
main:                   ; Label für den Start

 mov ax,0x0000          ; Data Segment Register
 mov ds,ax
 mov si, HelloWorld     ; String laden
 call PutStr            ; Wir starten die Prozedur PutStr

jmp $                   ; zurück zum Start

; Prozeduren
PutStr:                 ; Label für PutStr
 ; die Register setzen
 mov ah,0x0E            ; Wir aktivieren das Setzen von Zeichen 
 mov bh,0x00            ; Seitenzahl
 mov bl,0x07            ; Darstellung von Vordergrund / Hintergrund (Farben etc.)

.nextchar:              ; Sprungmarke, um den gesamten Zeichen-String abzuarbeiten
 lodsb                  ; Lädt das jeweilige Zeichen in al und erhöht Zeiger 
 or al,al               ; setzt zero flag, wenn al = 0

 jz .return             ; Falls zero flag gesetzt, dann springe zum Ende der Prozedur bei .return

 int 0x10               ; BIOS Video Interrupt
 
 jmp .nextchar          ; Springe zurück zu .nextchar
 
.return:                ; Sprungmarke
 ret                    ; Zurück zum (Hauptprogramm) Main

; Daten

HelloWorld db 'Hallo, Welt',13,10,0

; End Matter
times 510-($-$$) db 0   ; Der Rest wird immer mit Nullen aufgefüllt
dw 0xAA55               ; Jeder Bootloader braucht diese Signatur
