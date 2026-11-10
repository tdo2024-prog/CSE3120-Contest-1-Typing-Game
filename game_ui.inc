
; update timer without moving the player's cursor while typing
; Ch. 5 Gotoxy; 
; Ch. 7 DIV; Win32 console API
ShowCountdown PROC USES eax ebx edx
   call GetMseconds
   sub eax, startTime
   cmp eax, durationMs
   jb HasTime
   mov eax, 0
   jmp CheckSeconds

HasTime:
   mov ebx, durationMs
   sub ebx, eax
   mov eax, ebx
   add eax, 999
   xor edx, edx
   mov ebx, 1000
   div ebx

CheckSeconds:
   cmp eax, lastSeconds
   je CountdownDone
   mov lastSeconds, eax
   push eax

   ; save current console cursor position
   INVOKE GetConsoleScreenBufferInfo, outHandle, ADDR consoleInfo

   ; show countdown at column 0, row 4
   mov dh, 4
   mov dl, 0
   call Gotoxy
   mov edx, OFFSET msgCountdown
   call WriteString
   pop eax
   call WriteDec
   mov edx, OFFSET msgClear
   call WriteString

   ; bring back cursor so typing continues normally
   mov dh, BYTE PTR consoleInfo.dwCursorPosition.Y
   mov dl, BYTE PTR consoleInfo.dwCursorPosition.X
   call Gotoxy

CountdownDone:
   ret
ShowCountdown ENDP
