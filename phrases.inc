; phrases for player to type
phrase1 BYTE "This is the best game ever",0
phrase2 BYTE "Assembly is really fun",0
phrase3 BYTE "Hello  Florida Tech",0
phrase4 BYTE "Keep calm and dream on",0
phrase5 BYTE "Programming is life",0
phrase6 BYTE "Stacks and nodes may break my bones",0

; storing phrases in a table (Irvine chapter 4.4)
phraseTable DWORD OFFSET phrase1, OFFSET phrase2, OFFSET phrase3, OFFSET phrase4, OFFSET phrase5, OFFSET phrase6
phraseCount DWORD LENGTHOF phraseTable