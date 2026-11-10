; clearing used phrases before next round (Irvine chapters 4, arrays, and chapter 5, procedures)
ResetPhrases PROC USES ecx edi
   mov ecx, phraseCount
   mov edi, OFFSET usedFlags
ResetLoop:
   mov BYTE PTR [edi], 0
   inc edi
   loop ResetLoop
   mov usedCount, 0
   ret
ResetPhrases ENDP