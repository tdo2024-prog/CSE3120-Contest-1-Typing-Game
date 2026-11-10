; displays correct answers at the end of the game (Irvine, chapter 5.4 writestring and writedec)
.data
msgCorrect BYTE "Correct phrases: ",0
.code
ShowScore PROC USES eax edx
   mov edx, OFFSET msgCorrect
   call WriteString
   mov eax, correctCount
   call WriteDec
   call Crlf
   ret
ShowScore ENDP