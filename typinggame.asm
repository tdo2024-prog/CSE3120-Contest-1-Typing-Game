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

.code
main PROC
   
   mov edx, OFFSET msgTitle
   call WriteString
   call Crlf
   INVOKE ExitProcess, 0

main ENDP
END main
