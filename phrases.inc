; phrases for player to type
phrase1 BYTE "This is the best game ever",0
phrase2 BYTE "Assembly is really fun",0
phrase3 BYTE "Hello Florida Tech",0
phrase4 BYTE "Keep calm and MOV on",0
phrase5 BYTE "Programming is life",0
phrase6 BYTE "Stacks and nodes may break my bones",0
phrase7 BYTE "Flipping bits and shifting bytes",0
phrase8 BYTE "Zero out the bad vibes",0
phrase9 BYTE "Let the blessings stack overflow",0
phrase10 BYTE "INC ECX",0
phrase11 BYTE "DEC ESI",0
phrase12 BYTE "JNE EndOfLoopBody",0

; jarvis dialogue and humor
phrase13 BYTE "Sir the build completed with reservations",0
phrase14 BYTE "I have prepared several bad ideas",0
phrase15 BYTE "That was bold even for you",0
phrase16 BYTE "Power levels are mostly encouraging",0
phrase17 BYTE "I ran the numbers they look dramatic",0
phrase18 BYTE "Please try not to break the ceiling",0
phrase19 BYTE "The suit would not recommend that",0
phrase20 BYTE "I am detecting confidence without evidence",0

; dry assistant humor
phrase21 BYTE "Your plan has been noted and feared",0
phrase22 BYTE "I can explain this later if we survive",0
phrase23 BYTE "That command felt deeply personal",0
phrase24 BYTE "I optimized the chaos as requested",0
phrase25 BYTE "Would you like the honest error report",0
phrase26 BYTE "The machine is judging your timing",0
phrase27 BYTE "I have several concerns sir",0
phrase28 BYTE "That outcome was statistically unwise",0

; storing phrases in a table (Irvine chapter 4.4)

phraseTable DWORD OFFSET phrase1, OFFSET phrase2, OFFSET phrase3, OFFSET phrase4, OFFSET phrase5,
   OFFSET phrase6, OFFSET phrase7, OFFSET phrase8, OFFSET phrase9, OFFSET phrase10,
   OFFSET phrase11, OFFSET phrase12, OFFSET phrase13, OFFSET phrase14, OFFSET phrase15,
   OFFSET phrase16, OFFSET phrase17, OFFSET phrase18, OFFSET phrase19, OFFSET phrase20,
   OFFSET phrase21, OFFSET phrase22, OFFSET phrase23, OFFSET phrase24,
   OFFSET phrase25, OFFSET phrase26, OFFSET phrase27, OFFSET phrase28
   ; LENGTHOF tracks the number of phrases

phraseCount DWORD LENGTHOF phraseTable

; tracking which phases that were already used (Irvine chapter 3 and 4)
usedFlags BYTE LENGTHOF phraseTable DUP(0)
usedCount DWORD 0