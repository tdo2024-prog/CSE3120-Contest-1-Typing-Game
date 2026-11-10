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
phrase29 BYTE "The arc reactor is emotionally unavailable",0
phrase30 BYTE "The lab lights are acting suspicious",0
phrase31 BYTE "Please remain calm while I improvise",0
phrase32 BYTE "This feels expensive already",0
phrase33 BYTE "I have isolated the dramatic variables",0
phrase34 BYTE "The armor has trust issues again",0
phrase35 BYTE "The diagnostics have entered their flop era",0
phrase36 BYTE "The protocol was more of a suggestion",0

; increasingly strange...
phrase37 BYTE "The machine knows what you did",0
phrase38 BYTE "Something in the system is blinking back",0
phrase39 BYTE "The logs are becoming self aware",0
phrase40 BYTE "I do not remember authorizing that",0
phrase41 BYTE "Someone else has used this terminal",0
phrase42 BYTE "The silence between keys is suspicious",0
phrase43 BYTE "I thought that process was terminated",0
phrase44 BYTE "That was not a system message",0

; one table of phrase addresses (Irvine, Ch. 4.4)
phraseTable LABEL DWORD
   DWORD OFFSET phrase1, OFFSET phrase2, OFFSET phrase3, OFFSET phrase4
   DWORD OFFSET phrase5, OFFSET phrase6, OFFSET phrase7, OFFSET phrase8
   DWORD OFFSET phrase9, OFFSET phrase10, OFFSET phrase11, OFFSET phrase12
   DWORD OFFSET phrase13, OFFSET phrase14, OFFSET phrase15, OFFSET phrase16
   DWORD OFFSET phrase17, OFFSET phrase18, OFFSET phrase19, OFFSET phrase20
   DWORD OFFSET phrase21, OFFSET phrase22, OFFSET phrase23, OFFSET phrase24
   DWORD OFFSET phrase25, OFFSET phrase26, OFFSET phrase27, OFFSET phrase28
   DWORD OFFSET phrase29, OFFSET phrase30, OFFSET phrase31, OFFSET phrase32
   DWORD OFFSET phrase33, OFFSET phrase34, OFFSET phrase35, OFFSET phrase36
   DWORD OFFSET phrase37, OFFSET phrase38, OFFSET phrase39, OFFSET phrase40
   DWORD OFFSET phrase41, OFFSET phrase42, OFFSET phrase43, OFFSET phrase44

phraseTableEnd LABEL DWORD
PHRASE_TOTAL = (phraseTableEnd - phraseTable) / 4

phraseCount DWORD PHRASE_TOTAL
usedFlags BYTE PHRASE_TOTAL DUP(0) ; one byte allocated for each phrase
usedCount DWORD 0
