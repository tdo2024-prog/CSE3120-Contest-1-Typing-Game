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
msgTitle BYTE "ASSEMBLY TYPING GAME", 0


; Timer menu (Irvine, Chapter 3.4)
msgMenu BYTE "Select timer:",0Dh,0Ah
        BYTE "[1] 30 seconds",0Dh,0Ah
        BYTE "[2] 60 seconds",0Dh,0Ah,0

timerSeconds DWORD 0
msgSelected BYTE "Selected duration (seconds): ",0

.code
main PROC
  
   mov edx, OFFSET msgTitle
   call WriteString
   call Crlf

   ; Display menu using Irvine32 (Chapter 5.4)
   mov edx, OFFSET msgMenu
   call WriteString

   
   ; Select game duration, Irvine, Chapter 5.4 (ReadChar, WriteDec)
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


   INVOKE ExitProcess, 0

main ENDP
END main
