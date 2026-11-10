; removing the previous typed character (Irvine, chapter 4 arrays and chapter 5 writechar)
HandleBackspace PROC USES eax esi
   mov esi, inputIndex
   cmp esi, 0
   je BackspaceDone     ; nothing to backspace, returns

   dec esi
   mov inputIndex, esi
   mov userBuffer[esi], 0
   mov al, 8
   call WriteChar
   mov al, ' '          ; clearing position
   call WriteChar
   mov al, 8
   call WriteChar
BackspaceDone:
   ret
HandleBackspace ENDP