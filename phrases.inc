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

; storing phrases in a table (Irvine chapter 4.4)

phraseTable DWORD OFFSET phrase1, OFFSET phrase2, OFFSET phrase3, OFFSET phrase4, OFFSET phrase5,
   OFFSET phrase6, OFFSET phrase7, OFFSET phrase8, OFFSET phrase9, OFFSET phrase10,
   OFFSET phrase11, OFFSET phrase12, OFFSET phrase13, OFFSET phrase14, OFFSET phrase15,
   OFFSET phrase16, OFFSET phrase17, OFFSET phrase18, OFFSET phrase19, OFFSET phrase20
   ; LENGTHOF phraseTable will now evaluate to 20, so the game automatically knows there are 20 available phrases 
   ; also creates 20 used flags.
phraseCount DWORD LENGTHOF phraseTable

; tracking which phases that were already used (Irvine chapter 3 and 4)
usedFlags BYTE LENGTHOF phraseTable DUP(0)
usedCount DWORD 0