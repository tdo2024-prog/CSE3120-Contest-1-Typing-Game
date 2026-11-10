; printing typed characters in green or red (Irvine chapter 5, SetTextColor, WriteChar)
ColorTypedChar PROC
   push eax
   ; al = typed, dl = what is expected
   cmp al, dl          
   jne BadColor
   mov eax, lightGreen
   jmp PrintColor
BadColor:
   mov eax, lightRed
PrintColor:
   call SetTextColor
   pop eax
   call WriteChar
   mov eax, lightGray
   call SetTextColor
   ret
ColorTypedChar ENDP