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

; title of game diplayed in cyan, menu and gameplay in light gray
msgTitle BYTE "========================================",0Dh,0Ah
         BYTE "       ESCAPE THE CPU // TERMINAL       ",0Dh,0Ah
         BYTE "========================================",0Dh,0Ah
         BYTE "        SYSTEM STATUS: ONLINE           ",0Dh,0Ah,0

msgTimeUp BYTE "Time's up... how'd you do?",0Dh,0Ah,0

; Timer menu (Irvine, Chapter 3.4)
msgMenu BYTE "Select timer:",0Dh,0Ah
        BYTE "[1] 30 seconds",0Dh,0Ah
        BYTE "[2] 60 seconds",0Dh,0Ah,0

timerSeconds DWORD 0
msgSelected BYTE "Selected duration (seconds): ",0

msgReady BYTE "Press SPACEBAR to start...",0Dh,0Ah,0
msgStarted BYTE "Let's begin!",0Dh,0Ah,0
msgReplay BYTE "Press R to replay, press any other key to exit.",0Dh,0Ah,0


; Timer values (Irvine, Ch. 5, Sec. 5.4.3)
startTime DWORD 0
durationMs DWORD 0
userBuffer BYTE 64 DUP(0)  ; 64-byte buffer initialized to zero
inputIndex DWORD 0         ; tracks number of characters tyoed
targetPtr DWORD 0          ; stores address of chosen phrase
correctCount DWORD 0       ; # of correctly typed phrases
correctChars DWORD 0       ; characters from correct submission 
elapsedMs DWORD 0          ; actual duration in ms


.code
main PROC

   call Clrscr    
   mov eax, lightCyan      ; clear console screen and display title in cyan (Chapter 5)
   call SetTextColor
   mov edx, OFFSET msgTitle
   call WriteString
   mov eax, lightGray
   call SetTextColor
   call Crlf

   call Randomize ; Irvine32 random number generator (Chapter 5)

   ShowMenu:
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
        call GetMseconds      ; check time left before choosing another phrase
        sub eax, startTime
        cmp eax, durationMs
        jae GameTimeup

        mov eax, usedCount
        cmp eax, phraseCount  ; stop selecting when every phrase has been used
        jb PhrasesAvailable   ; (Chapter 6 cmp and jumps)
        call ResetPhrases
    PhrasesAvailable:

        mov eax, phraseCount  ; choose easier prompts before stranger dialogue
        cmp usedCount, 2
        jae ThirdPhrase
        mov eax, 12
        jmp RollPhrase
    ThirdPhrase:
        cmp usedCount, 2
        jne RollPhrase
        mov eax, 24
    RollPhrase:
        call RandomRange
        cmp usedCount, 2
        jne IndexReady
        add eax, 12
    IndexReady:
        
        mov ebx, eax          ; ebx holds random index for checking used phrases
        cmp usedFlags[ebx], 0
        jne PickPhrase        ; try again if phrase has been seen already
        mov usedFlags[ebx], 1 ; mark phrase as seen
        inc usedCount         ; add to count of chosen phrases

    shl eax, 2            ; multiply index by 4 to find DWORD ptr
    mov edx, phraseTable[eax]
    mov targetPtr, edx    ; save chosen phrase address in edx
    call WriteString
    call Crlf


    GameTimerLoop: 
       call GetMseconds    ; current time in eax
       sub eax, startTime  ; calculates elaspsed time (milliseconds)
       cmp eax, durationMs
       jae GameTimeUp      ; exits when the elapsed time >= duration selected (unsigned) 
       
       call ReadKey        ; sets zero flag when no key is available; check input, timer's still going
       jz NoKeyPressed     ; ZF = 1 means no input given
       cmp al, 0
       je NoKeyPressed     ; ignore special keys
       cmp al, 13
       je SubmitPhrase     ; hitting enter submits the phrase 
       cmp al, 8
       je ProcessBackspace 
       mov esi, inputIndex
       cmp esi, 63
       jae NoKeyPressed

       mov userBuffer[esi], al  ; each char is put into userBuffer and displayed
       mov BYTE PTR userBuffer[esi+1], 0 ; end input
       mov ebx, targetPtr
       mov dl, [ebx+esi]        ; expected character
       call ColorTypedChar      ; show character in green or red
       inc inputIndex
    NoKeyPressed:
       
       mov eax, 10
       call Delay          ; pause for 10ms before checking again
       jmp GameTimerLoop   

    ProcessBackspace:
        call HandleBackspace ; decreases inputIndex, clears last character, and removes from display
        jmp NoKeyPressed

    SubmitPhrase:
        INVOKE Str_compare, ADDR userBuffer, targetPtr   ; compare entered text with the target (Chapter 9.3)
        jne NextPhrase     ; skips correctCount when they are different
        inc correctCount   ; add to correct phrases when they match
        INVOKE Str_length, targetPtr  ; receives the phrase address and returns its length in EAX
        add correctChars, eax

    NextPhrase:
        call Crlf
        mov inputIndex, 0
        mov BYTE PTR userBuffer, 0
        jmp PickPhrase     ; choose another, unused, phrase


    GameTimeUp:
       call GetMseconds
       sub eax, startTime
       cmp eax, durationMs
       jbe SaveElapsed
       mov eax, durationMs

    SaveElapsed:
       mov elapsedMs, eax
       call Crlf
       mov edx, OFFSET msgTimeUp
       call WriteString
       call ShowScore      ; display correct phrase count
       call ShowWPM        ; display words per minute
       

       mov edx, OFFSET msgReplay
       call WriteString

    WaitForReplay:
       mov eax, 20
       call Delay         ; give Windows time to process keys
       call ReadKey       ; check keyboard without blocking
       jz WaitForReplay   ; keep on checking until a key arrives
       cmp al, 'r'
       je ReplayGame
       cmp al, 'R'
       jne ExitGame

    ReplayGame:
       call ResetPhrases    ; clears all the used flags
       mov correctCount, 0  ; resets stats and input
       mov correctChars, 0
       mov elapsedMs, 0
       mov inputIndex, 0
       mov BYTE PTR userBuffer, 0
       call Crlf
       jmp ShowMenu       ; jump back to start menu

    ExitGame:
       INVOKE ExitProcess, 0

main ENDP

INCLUDE phrase_logic.inc    ; phrase reset
INCLUDE typing_feedback.inc ; text color feedback
INCLUDE backspace.inc       ; backspace handling
INCLUDE stats.inc           ; stats for end of game
INCLUDE wpm.inc             ; wpm calculation

END main