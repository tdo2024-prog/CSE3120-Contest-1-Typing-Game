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

; storing phrases in a table (Irvine chapter 4.4)
phraseTable DWORD OFFSET phrase1, OFFSET phrase2, OFFSET phrase3, OFFSET phrase4, OFFSET phrase5, OFFSET phrase6, OFFSET phrase7, OFFSET phrase8, OFFSET phrase9, OFFSET phrase10, OFFSET phrase11, OFFSET phrase12
phraseCount DWORD LENGTHOF phraseTable

; tracking which phases that were already used (Irvine chapter 3 and 4)
usedFlags BYTE LENGTHOF phraseTable DUP(0)
usedCount DWORD 0