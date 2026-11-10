; calculating WPM (Irvine chapter 7, MUL and DIV)
.data
msgWPM BYTE "Words per minute: ",0
.code
; uses the formula: wpm = correct chars x 12000 (seconds -> milliseconds)
; also assumes 1 word = 5 chars (standard)
ShowWPM PROC USES eax ebx edx
   mov edx, OFFSET msgWPM
   call WriteString
   mov eax, correctChars
   mov ebx, 12000
   mul ebx
   mov ebx, elapsedMs
   cmp ebx, 0
   jne WpmDivide
   mov ebx, 1
WpmDivide:
   div ebx
   call WriteDec
   call Crlf
   ret
ShowWPM ENDP
