; =====================================================================
; Project: MASM Assembly Typing Test Game
; Author: Thomas Do & Madison Sujanani 
; Environment: Irvine32 Library (MASM / x86 Win32 Console)
; Description: A typing test featuring timer selection (30s/1m), 
;              real-time word prompts, WPM stats, and replay options.
; =====================================================================

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc

.data
INCLUDE phrases.inc ; use our phrase bank
msgTitle BYTE "ASSEMBLY TYPING GAME", 0
msgTimeUp BYTE "Time's up... how'd you do?",0Dh,0Ah,0

; Timer menu (Irvine, Chapter 3.4)
msgMenu BYTE "Select timer:",0Dh,0Ah
        BYTE "[1] 30 seconds",0Dh,0Ah
        BYTE "[2] 60 seconds",0Dh,0Ah,0

timerSeconds DWORD 0
msgSelected BYTE "Selected duration (seconds): ",0

msgReady BYTE "Press SPACEBAR to start...",0Dh,0Ah,0
msgStarted BYTE "Let's begin!",0Dh,0Ah,0


; Timer values (Irvine, Ch. 5, Sec. 5.4.3)
startTime DWORD 0
durationMs DWORD 0


.code
main PROC
  
   mov edx, OFFSET msgTitle
   call WriteString
   call Crlf
   call Randomize ; Irvine32 random number generator (Chapter 5)

   ; Display menu using Irvine32 (Chapter 5.4)
   mov edx, OFFSET msgMenu
   call WriteString

   
   ; Select game duration. Irvine, Chapter 5.4 (ReadChar, WriteDec)
    SelectTime:
       call ReadChar
       cmp al, '1'
       je Set30

       cmp al, '2'
       jne SelectTime
       mov timerSeconds, 60

       jmp ShowTime

    Set30:
       mov timerSeconds, 30

    ShowTime:
       mov edx, OFFSET msgSelected
       call WriteString
       mov eax, timerSeconds
       call WriteDec
       call Crlf

    mov edx, OFFSET msgReady
    call WriteString


    WaitForSpace: 
       call ReadChar  ; read a key into AL register
       cmp al, ' '    ; compare with empty space 
       jne WaitForSpace ; repeat if the spacebar wasnt pressed

    mov edx, OFFSET msgStarted ; waits for the user to hit the spacebar to continue. 
    call WriteString         ; Irvine, Ch. 5 and 6 (ReadChar, CMP, conditional jmp)

    mov eax, timerSeconds ; then start the timer
    mov ebx, 1000
    mul ebx               ; MUL converts seconds -> milliseconds
    mov durationMs, eax

    call GetMseconds      ; read current time into eax, to save the starting time
    mov startTime, eax

    PickPhrase: 
        mov eax, phraseCount  ; RandomRange selects a number from 0 to phraseCount - 1 (Chapter 5.4)
        call RandomRange
        
        mov ebx, eax          ; ebx holds random index for checking used phrases
        cmp usedFlags[ebx], 0
        jne PickPhrase        ; try again if phrase has been seen already
        mov usedFlags[ebx], 1 ; mark phrase as seen
        inc usedCount         ; add to count of chosen phrases


    shl eax, 2            ; multiply index by 4 to find DWORD ptr
    mov edx, phraseTable[eax]
    call WriteString
    call Crlf


    GameTimerLoop: 
       call GetMseconds    ; current time in eax
       sub eax, startTime  ; calculates elaspsed time (milliseconds)
       cmp eax, durationMs
       jae GameTimeUp      ; exits when the elapsed time >= duration selected (unsigned) 
       mov eax, 10
       call Delay          ; pause for 10ms before checking again
       jmp GameTimerLoop   

    GameTimeUp:
       call Crlf
       mov edx, OFFSET msgTimeUp
       call WriteString

   INVOKE ExitProcess, 0

main ENDP
END main
